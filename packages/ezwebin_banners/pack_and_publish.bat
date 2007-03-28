del /Q ezwebin_banners.ezpkg
C:\Progra~1\7-Zip\7z.exe a -r -ttar -x!*.cache -x!*.svn -x!pack_and_publish.bat ezwebin_banners.ezpkg
move /Y ezwebin_banners.ezpkg c:\www\packages.ez.no\ezpublish\3.9.1rc1\
