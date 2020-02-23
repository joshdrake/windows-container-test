FROM mcr.microsoft.com/windows/servercore:ltsc2019

RUN powershell.exe -Command Invoke-WebRequest https://www.python.org/ftp/python/3.7.6/python-3.7.6-amd64.exe -OutFile d:\a\1\s\python-3.7.6-amd64.exe

RUN powershell.exe -Command \
    $ErrorActionPreference = 'Stop'; \
    Start-Process c:\python-3.7.6-amd64.exe -ArgumentList '/quiet InstallAllUsers=1 PrependPath=1 Include_pip=0' -Wait; \
    Remove-Item c:\python-3.7.6-amd64.exe -Force

RUN powershell.exe -Command \
    $ErrorActionPreference = 'Stop'; \
    Invoke-WebRequest https://bootstrap.pypa.io/get-pip.py -OutFile c:\get-pip.py ; \
    Start-Process python C:\get-pip.py pip==20.0.2 \
    Remove-Item c:\get-pipe.py -Force

RUN powershell.exe -Command \
    $ErrorActionPreference = 'Stop'; \
    pip --version

CMD [ "python.exe" ]