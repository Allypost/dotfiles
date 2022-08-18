local utils = require 'mp.utils'

local function get_os_name()
    -- Return two strings describing the OS name and OS architecture.
    -- For Windows, the OS identification is based on environment variables
    -- On unix, a call to uname is used.
    -- 
    -- OS possible values: Windows, Linux, Mac, BSD, Solaris
    -- Arch possible values: x86, x86864, powerpc, arm, mips
    -- 
    -- On Windows, detection based on environment variable is limited
    -- to what Windows is willing to tell through environement variables. In particular
    -- 64bits is not always indicated so do not rely hardly on this value.

    local raw_os_name, raw_arch_name = '', ''

    -- LuaJIT shortcut
    if jit and jit.os and jit.arch then
        raw_os_name = jit.os
        raw_arch_name = jit.arch
        -- print( ("Debug jit name: %q %q"):format( raw_os_name, raw_arch_name ) )
    else
        if package.config:sub(1,1) == '\\' then
            -- Windows
            local env_OS = os.getenv('OS')
            local env_ARCH = os.getenv('PROCESSOR_ARCHITECTURE')
            -- print( ("Debug: %q %q"):format( env_OS, env_ARCH ) )
            if env_OS and env_ARCH then
                raw_os_name, raw_arch_name = env_OS, env_ARCH
            end
        else
            -- other platform, assume uname support and popen support
            raw_os_name = io.popen('uname -s','r'):read('*l')
            raw_arch_name = io.popen('uname -m','r'):read('*l')
        end
    end

    raw_os_name = (raw_os_name):lower()
    raw_arch_name = (raw_arch_name):lower()

    -- print( ("Debug: %q %q"):format( raw_os_name, raw_arch_name) )

    local os_patterns = {
        ['windows']     = 'Windows',
        ['linux']       = 'Linux',
        ['osx']         = 'Mac',
        ['mac']         = 'Mac',
        ['darwin']      = 'Mac',
        ['^mingw']      = 'Windows',
        ['^cygwin']     = 'Windows',
        ['bsd$']        = 'BSD',
        ['sunos']       = 'Solaris',
    }
    
    local arch_patterns = {
        ['^x86$']           = 'x86',
        ['i[%d]86']         = 'x86',
        ['amd64']           = 'x86_64',
        ['x86_64']          = 'x86_64',
        ['x64']             = 'x86_64',
        ['power macintosh'] = 'powerpc',
        ['^arm']            = 'arm',
        ['^mips']           = 'mips',
        ['i86pc']           = 'x86',
    }

    local os_name, arch_name = 'unknown', 'unknown'

    for pattern, name in pairs(os_patterns) do
        if raw_os_name:match(pattern) then
            os_name = name
            break
        end
    end
    for pattern, name in pairs(arch_patterns) do
        if raw_arch_name:match(pattern) then
            arch_name = name
            break
        end
    end
    return os_name, arch_name
end

local function clipboard_set_windows(text)
    return mp.command_native({
        name = "subprocess",
        args = {
            'powershell', '-NoProfile', '-Command', string.format([[& {
                Trap {
                    Write-Error -ErrorRecord $_
                    Exit 1
                }
                Add-Type -AssemblyName PresentationCore
                [System.Windows.Clipboard]::SetText('%s')
            }]], text)
        },
        playback_only = false,
        capture_stdout = true,
    })
end

local function clipboard_set_osx(text)
    return os.execute(string.format("echo $'%s' | pbcopy", text))
end

local function clipboard_set_linux(text)
    return os.execute(string.format("echo $'%s' | xclip -sel clip", text))
end

local function clipboard_set(text)
    local os_name = get_os_name()
    local handlers = {
        Linux = clipboard_set_linux,
        Windows = clipboard_set_windows,
        Mac = clipboard_set_osx,
    }
    local handler = handlers[os_name]

    print('Detected OS:', os_name)
    
    if (handler) then
        return handler(text)
    end

    return nil
end


local function cts_handler()
    local formatted_ts = mp.get_property_osd('time-pos')
    local string_ts = mp.get_property('time-pos')
    local ms = string_ts:match("[0-9]+[.]([0-9]+)")

    local final_ts = formatted_ts .. "." .. ms

    print("Copying " .. final_ts)
    local res = clipboard_set(final_ts)
    print("\t", utils.to_string(res))
    print("Copied")
end

mp.add_key_binding("ctrl+t", "copy-timestamp", cts_handler)
