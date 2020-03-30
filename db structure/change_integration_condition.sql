CREATE TABLE changeintegrationcondition (
    cic_id                    NUMBER(10) NOT NULL,
    cic_condition             VARCHAR2(4000) not null
);


ALTER TABLE changeintegrationcondition ADD CONSTRAINT condition_pk PRIMARY KEY ( cic_id );

insert into changeintegrationcondition values (1, 'If there is a new data source');