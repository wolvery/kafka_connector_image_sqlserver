FROM confluentinc/cp-kafka-connect-base:5.5.0

RUN confluent-hub install --no-prompt debezium/debezium-connector-sqlserver:0.9.4
RUN confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:5.5.0
RUN confluent-hub install --no-prompt confluentinc/kafka-connect-azure-sql-dw:1.0.0-preview

# Remove o JTDS para evitar seu uso pelo kafka connector.
RUN rm /usr/share/confluent-hub-components/confluentinc-kafka-connect-jdbc/lib/jtds-1.3.1.jar

# Copia os drivers do debezium para serem utilizados pelo kafka connect.
RUN cp /usr/share/confluent-hub-components/debezium-debezium-connector-sqlserver/lib/mssql-jdbc-7.2.2.jre8.jar /usr/share/confluent-hub-components/confluentinc-kafka-connect-jdbc/lib/
RUN cp /usr/share/confluent-hub-components/confluentinc-kafka-connect-jdbc/lib/*.jar /usr/share/java/kafka
