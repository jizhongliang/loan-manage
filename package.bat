call mvn clean package -Ddownloadsources=true -Ddownloadjavadocs=true -Dmaven.test.skip=true -Pproduct -e
rem mvn clean package -Pdev -Dmaven.test.skip=true -e -U -pl  loan-p2p-service/ -am
pause