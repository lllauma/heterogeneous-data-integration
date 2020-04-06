CREATE TABLE changeadaptationcondition (
    cac_id                    NUMBER(10) NOT NULL,
    cac_condition             VARCHAR2(4000) not null
);


ALTER TABLE changeadaptationcondition ADD CONSTRAINT condition_pk PRIMARY KEY ( cac_id );

insert into changeadaptationcondition values (1, 'If there is a new data source');