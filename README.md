# vm_templates
- 透過 ssh 遠端執行腳本

## Requirement
### 1. 設定好 sudoer
- Run as root
```bash
echo "ycku    ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/sysadmin
```
### 2. 設定好 ssh with key
- 在執行此程式的主機
```bash
ssh-keygen -t rsa -b 4096
ssh-copy-id -i ~/.ssh/id_rsa.pub ycku@target_server
```
