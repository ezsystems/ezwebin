del /Q ezwebin_classes.ezpkg
C:\Progra~1\7-Zip\7z.exe a -r -ttar -x!*.cache -x!*.svn -x!pack_and_publish.bat ezwebin_classes.ezpkg
move /Y ezwebin_classes.ezpkg c:\www\packages.ez.no\ezpublish\3.9.1.rc1\
