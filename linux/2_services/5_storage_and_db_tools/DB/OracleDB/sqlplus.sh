# install in ubuntu
# https://stackoverflow.com/questions/27717312/sqlplus-error-while-loading-shared-libraries-libsqlplus-so-cannot-open-shared/48405058

# copy Basic Package (ZIP)
# https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html
unzip instantclient-basic-linux.x64-21.4.0.0.0dbru.zip
export ORACLE_HOME=/home/den/Downloads/instantclient_21_4
export LD_LIBRARY_PATH="$ORACLE_HOME"
export PATH="$ORACLE_HOME:$PATH"
sqlplus
