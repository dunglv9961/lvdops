@echo off
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set backdate=%%c-%%a-%%b)
rem e:
rem cd E:\Data\lvdops
git add -A
git commit -a -m %backdate%
git push