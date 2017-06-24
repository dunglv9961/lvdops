@echo off
rem For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set backdate=%%c-%%a-%%b)
e:
cd E:\Data\lvdops
git add -A
git commit -a -m "Backup"
git pushs