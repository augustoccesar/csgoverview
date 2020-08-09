;General

!define APP_NAME "csgoverview"
Name "${APP_NAME}"
OutFile "${APP_NAME}_windows_v0.7.1_install.exe"
LicenseData "LICENSE" ;FIXME correct?
RequestExecutionLevel admin
Unicode True
;set default InstallDir
InstallDir "$PROGRAMFILES\${APP_NAME}"
; check string in registry and use it as the install dir if that string is valid
InstallDirRegKey HKCU "Software\${APP_NAME}" ""

;Pages

Page license
Page components
Page directory
Page instfiles
UninstPage uninstConfirm
UninstPage instfiles

Section "Install csgoverview" SecCSGOverview

    SetOutPath "$INSTDIR"

    FILE csgoverview.exe
    FILE DejaVuSans.ttf
    FILE LICENSE ;FIXME?

    CreateDirectory $INSTDIR\assets\maps

    ;Store installation folder
    WriteRegStr HKCU "Software\${APP_NAME}" "" $INSTDIR

    ;Create uninstaller
    WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

Section "Download Maps" SecMaps

    SetOutPath "$INSTDIR\assets\maps"

    ; DOWNLOADS
    inetc::get "https://raw.githubusercontent.com/zoidbergwill/csgo-overviews/master/overviews/de_overpass.jpg"
    inetc::get "https://raw.githubusercontent.com/zoidbergwill/csgo-overviews/master/overviews/de_mirage.jpg"
    inetc::get "https://raw.githubusercontent.com/zoidbergwill/csgo-overviews/master/overviews/de_vertigo.jpg"
    inetc::get "https://raw.githubusercontent.com/zoidbergwill/csgo-overviews/master/overviews/de_vertigo_lower.jpg"
    inetc::get "https://raw.githubusercontent.com/zoidbergwill/csgo-overviews/master/overviews/de_nuke.jpg"
    inetc::get "https://raw.githubusercontent.com/zoidbergwill/csgo-overviews/master/overviews/de_nuke_lower.jpg"
    inetc::get "https://raw.githubusercontent.com/zoidbergwill/csgo-overviews/master/overviews/de_cache.jpg"
    inetc::get "https://raw.githubusercontent.com/zoidbergwill/csgo-overviews/master/overviews/de_inferno.jpg"
    inetc::get "https://raw.githubusercontent.com/zoidbergwill/csgo-overviews/master/overviews/de_train.jpg"
    inetc::get "https://raw.githubusercontent.com/zoidbergwill/csgo-overviews/master/overviews/de_dust2.jpg"

SectionEnd

;Descriptions

;LangString DESC_SecCSGOverview ${LANG_ENGLISH} "Install csgoverview program."
;LangString DESC_SecMaps ${LANG_ENGLISH} "Download overview maps (requires internet connection)."
;FIXME need to assign descriptions to sections (only modern ui?)

;Uninstaller Section

Section "un.Uninstall"

    Delete "$INSTDIR\assets\maps\de_overpass.jpg"
    Delete "$INSTDIR\assets\maps\de_mirage.jpg"
    Delete "$INSTDIR\assets\maps\de_vertigo.jpg"
    Delete "$INSTDIR\assets\maps\de_vertigo_lower.jpg"
    Delete "$INSTDIR\assets\maps\de_nuke.jpg"
    Delete "$INSTDIR\assets\maps\de_nuke_lower.jpg"
    Delete "$INSTDIR\assets\maps\de_cache.jpg"
    Delete "$INSTDIR\assets\maps\de_inferno.jpg"
    Delete "$INSTDIR\assets\maps\de_train.jpg"
    Delete "$INSTDIR\assets\maps\de_dust2.jpg"

    RMDIR "$INSTDIR\assets\maps"
    RMDIR "$INSTDIR\assets"

    Delete "$INSTDIR\csgoverview.exe"
    Delete "$INSTDIR\DejaVuSans.ttf"
    Delete "$INSTDIR\LICENSE"

    RMDir "$INSTDIR"

    DeleteRegKey /ifempty HKCU "Software\${APP_NAME}"

SectionEnd
