; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Shareview Professional"
!define PRODUCT_VERSION "4.7"
!define PRODUCT_PUBLISHER "Miridix"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\shareview.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\Shareview"
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
;  File "sv.url"
;  File "sv2.url"
  File "un_closesv.exe"
  File "madCHook.dll"
  File "PSMFireW.dll"
  File "PSMScrLk.dll"
;  ExecShell "open" "$INSTDIR\sv.url" SW_HIDE
  File "license.rtf"
  File "readme.rtf"

  SetOutPath "$INSTDIR\help"
  CreateDirectory "$SMPROGRAMS\Shareview\Help"
  File "help\help.htm"
  File "help\netstat.txt"

  SetOutPath "$INSTDIR\help\help.files"
  CreateDirectory "$SMPROGRAMS\Shareview\Help\help.files"

  File "help\help.files\image022.jpg"
  File "help\help.files\image020.jpg"
  File "help\help.files\image018.jpg"
  File "help\help.files\image016.jpg"
  File "help\help.files\image015.jpg"
  File "help\help.files\image014.jpg"
  File "help\help.files\image013.jpg"
  File "help\help.files\image012.jpg"
  File "help\help.files\image010.jpg"
  File "help\help.files\image008.jpg"
  File "help\help.files\image006.jpg"
  File "help\help.files\image002.jpg"
  File "help\help.files\image027.gif"
  File "help\help.files\image029.gif"
  File "help\help.files\image023.gif"


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
  ExecShell "open" "$INSTDIR\un_closesv.exe" SW_HIDE

  Delete "$DESKTOP\Shareview.lnk"

  Delete "$INSTDIR\license.rtf"
  Delete "$INSTDIR\madCHook.dll"
  Delete "$INSTDIR\PSMFireW.dll"
  Delete "$INSTDIR\PSMScrLk.dll"
  Delete "$INSTDIR\readme.rtf"
  Delete "$INSTDIR\ShareView.exe"
  Delete "$INSTDIR\shareview.ini"
  Delete "$INSTDIR\shareview_log.mdb"
  Delete "$INSTDIR\sv.url"
  Delete "$INSTDIR\sv2.url"
  Delete "$INSTDIR\un_closesv.exe"
  Delete "$INSTDIR\uninst.exe"

  RMDir /r $SMPROGRAMS\Shareview
  RMDIR /r $INSTDIR\Help\help.files
  RMDIR /r $INSTDIR\Help
  RMDIR /r $INSTDIR
  RMDir $INSTDIR

  Delete "$INSTDIR"
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"

  SetAutoClose true
SectionEnd
