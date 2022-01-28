require 'ferrum'
require 'base64'
def u(text)
    w = text.split(' ')
    fin = "https://translate.google.com/?sl=en&tl=ru&text="
    w.each {|x| fin+="#{x}%20"}
    return fin + "&op=translate"
end


cmd = %{$Shortcut = Get-ChildItem "C:/ProgramData/Microsoft/Windows/Start Menu/Programs/Google Chrome.lnk"
    $Shell = New-Object -ComObject WScript.Shell
    $Shell.CreateShortcut($Shortcut).targetpath}

encoded_cmd = Base64.strict_encode64(cmd.encode('utf-16le'))
res = `powershell.exe -encodedCommand #{encoded_cmd}`

system("cls")

browser = Ferrum::Browser.new(:browser_path => res[0..-2])
phrase = gets()
browser.go_to u(phrase.to_s)
sleep(1)
mass = []
y = browser.css("span")
for i in y do
    if i.text[0] in ('А'..'я') then
        mass << i.text
    end
end

mass.sort
puts mass[2]

gets()