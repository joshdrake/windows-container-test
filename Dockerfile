# escape=`

FROM mcr.microsoft.com/windows/servercore:ltsc2019

ENV PYTHON_VERSION 3.7.6
ENV PYTHON_RELEASE 3.7.6

RUN powershell.exe -Command `
    $ErrorActionPreference = 'Stop'; `
    wget https://www.python.org/ftp/python/3.7.6/python-3.7.6-amd64.exe -OutFile c:\python-3.7.6-amd64.exe ; `
    Start-Process c:\python-3.7.6-amd64.exe -ArgumentList '/quiet InstallAllUsers=1 PrependPath=1 Include_pip=0' -Wait ; `
    Remove-Item c:\python-3.7.6-amd64.exe -Force

# if this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'"
ENV PYTHON_PIP_VERSION 20.0.2

RUN Write-Host ('Installing pip=={0} ...' -f $env:PYTHON_PIP_VERSION); \
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
	(New-Object System.Net.WebClient).DownloadFile('https://bootstrap.pypa.io/get-pip.py', 'get-pip.py'); \
	python get-pip.py \
		--disable-pip-version-check \
		--no-cache-dir \
		('pip=={0}' -f $env:PYTHON_PIP_VERSION) \
	; \
	Remove-Item get-pip.py -Force; \
	\
	Write-Host 'Verifying pip install ...'; \
	pip --version; \
	\
	Write-Host 'Complete.';

CMD [ "python.exe" ]