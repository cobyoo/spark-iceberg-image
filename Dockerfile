FROM jupyter/pyspark-notebook:latest

USER root

RUN wget -qO- https://dlcdn.apache.org/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz | tar xvz -C /usr/local/ && \
    cd /usr/local && ln -s spark-3.5.1-bin-hadoop3 spark

RUN wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-common/3.3.4/hadoop-common-3.3.4.jar -P /usr/local/spark/jars/ && \
    wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.4/hadoop-aws-3.3.4.jar -P /usr/local/spark/jars/ && \
    wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.262/aws-java-sdk-bundle-1.12.262.jar -P /usr/local/spark/jars/ && \
    wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-3.5_2.12/1.5.2/iceberg-spark-runtime-3.5_2.12-1.5.2.jar -P /usr/local/spark/jars/

ENV SPARK_HOME=/usr/local/spark
ENV PATH=$PATH:$SPARK_HOME/bin
ENV SPARK_OPTS="--driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --executor-memory 4G --total-executor-cores 3"
ENV SPARK_JARS=/usr/local/spark/jars/hadoop-common-3.3.4.jar,/usr/local/spark/jars/hadoop-aws-3.3.4.jar,/usr/local/spark/jars/aws-java-sdk-bundle-1.12.262.jar,/usr/local/spark/jars/iceberg-spark-runtime-3.5_2.12-1.5.2.jar

ENV JUPYTER_CONFIG_DIR=/home/elicer/.jupyter
RUN mkdir -p $JUPYTER_CONFIG_DIR && \
    echo "c.NotebookApp.token = ''" >> $JUPYTER_CONFIG_DIR/jupyter_notebook_config.py

RUN mkdir -p /home/elicer/.jupyter/lab/workspaces && \
    mkdir -p /home/elicer/spark-warehouse && \
    mkdir -p /home/elicer/work && \
    chown -R $NB_UID:$NB_GID /home/elicer

ENV HOME=/home/elicer
WORKDIR $HOME

USER $NB_UID

CMD ["start-notebook.sh", "--NotebookApp.notebook_dir=/home/elicer/"]

