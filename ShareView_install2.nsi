; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Shareview Professional"
!define PRODUCT_VERSION "2.71"
!define PRODUCT_PUBLISHER "Miridix"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\shareview.exe .exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; MUI 1.67 compatible ------
!include "MUI.nsh"


; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "license.rtf"

; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\Shareview.exe"
!define MUI_FINISHPAGE_SHOWREADME "readme.rtf"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "shareview_setup.exe"
InstallDir "$PROGRAMFILES\ShareView"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  CreateDirectory "$SMPROGRAMS\Shareview"
  CreateShortCut "$SMPROGRAMS\Shareview\Shareview.lnk" "$INSTDIR\Shareview.exe"
  CreateShortCut "$SMPROGRAMS\Shareview\Miridix.lnk" "$INSTDIR\sv.url"
  CreateShortCut "$DESKTOP\Shareview.lnk" "$INSTDIR\Shareview.exe"
  SetOutPath "$INSTDIR"
  File "Shareview.exe"
  File "sv.url"
  File "sv2.url"
  File "madCHook.dll"
  File "PSMFireW.dll"
  File "PSMScrLk.dll"
  ExecShell "open" "$INSTDIR\sv.url" SW_HIDE
  File "license.rtf"
  File "readme.rtf"

  SetOutPath "$INSTDIR\help"
  CreateDirectory "$SMPROGRAMS\Shareview\Help"
  File "help\help.htm"
  File "help\netstat.txt"

  SetOutPath "$INSTDIR\help\help.files"
  CreateDirectory "$SMPROGRAMS\Shareview\Help\help.files"
  File "help\help.files\filelist.xml"
  File "help\help.files\image001.jpg"
  File "help\help.files\image002.jpg"
  File "help\help.files\image003.emz"
  File "help\help.files\image004.gif"
  File "help\help.files\image005.png"
  File "help\help.files\image006.jpg"
  File "help\help.files\image007.png"
  File "help\help.files\image008.jpg"
  File "help\help.files\image009.png"
  File "help\help.files\image010.jpg"
  File "help\help.files\image011.png"
  File "help\help.files\image012.jpg"
  File "help\help.files\image013.gif"
  File "help\help.files\image014.gif"
  File "help\help.files\image015.gif"
  File "help\help.files\image016.gif"
  File "help\help.files\image017.png"
  File "help\help.files\image018.jpg"
  File "help\help.files\image019.png"
  File "help\help.files\image020.jpg"
  File "help\help.files\image021.jpg"
  File "help\help.files\image022.jpg"
  File "help\help.files\image023.png"
  File "help\help.files\image024.jpg"
  File "help\help.files\image025.png"
  File "help\help.files\image026.jpg"
  File "help\help.files\image027.png"
  File "help\help.files\image028.jpg"
  File "help\help.files\image029.png"
  File "help\help.files\image030.jpg"
  File "help\help.files\image031.png"
  File "help\help.files\image032.jpg"
  File "help\help.files\image033.png"
  File "help\help.files\image034.jpg"
  File "help\help.files\image035.jpg"
  File "help\help.files\image036.jpg"
  File "help\help.files\image037.png"
  File "help\help.files\image038.jpg"
  File "help\help.files\image039.jpg"
  File "help\help.files\image040.jpg"
  File "help\help.files\image041.png"
  File "help\help.files\image042.jpg"
  File "help\help.files\image043.jpg"
  File "help\help.files\image044.jpg"
  File "help\help.files\image045.jpg"
  File "help\help.files\image046.jpg"
  File "help\help.files\oledata.mso"


SectionEnd

Section -AdditionalIcons
  CreateShortCut "$SMPROGRAMS\Shareview\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\Shareview.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\Shareview.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function .onInit
FunctionEnd

Function .onInstSuccess
FunctionEnd


Function un.onUninstSuccess
  ExecShell "open" "$INSTDIR\sv2.url" SW_HIDE
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) succesful deleted."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "You want to delete $(^Name)?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\ImportTables.ini"
;  Delete "$INSTDIR\Shareview.ini"
  Delete "$INSTDIR\Shareview.exe"

  Delete "$SMPROGRAMS\Shareview\Uninstall.lnk"
  Delete "$DESKTOP\Shareview.lnk"
  Delete "$SMPROGRAMS\Shareview\Shareview.lnk"

  Delete "$SYSDIR\drivers\IPFWHook.sys"
  Delete "$SYSDIR\TIPFWHook.dll"
  Exec '"regsvr32.exe" $SYSDIR\TIPFWHook.dll -u -s'

  RMDir "$SMPROGRAMS\Shareview"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"

  SetAutoClose true
SectionEnd
