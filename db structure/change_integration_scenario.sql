CREATE TABLE changeintegrationscenario (
    cis_id                    NUMBER(10) NOT NULL,
    cis_change_id             NUMBER(10,0) not null,
    cis_operation_id          number(10) not null,
    cis_parentscenario_id     number(10),
    cis_changetype_id         VARCHAR2(10 BYTE) not null
);

ALTER TABLE changeintegrationscenario ADD CONSTRAINT scenario_pk PRIMARY KEY ( cis_id );

ALTER TABLE changeintegrationscenario
    ADD CONSTRAINT cis_change_fk FOREIGN KEY ( cis_change_id )
        REFERENCES change ( ch_id );
        
ALTER TABLE changeintegrationscenario
    ADD CONSTRAINT cis_operation_fk FOREIGN KEY ( cis_operation_id )
        REFERENCES changeintegrationoperation ( cio_id );
        
ALTER TABLE changeintegrationscenario
    ADD CONSTRAINT cis_parentscenario_fk FOREIGN KEY ( cis_parentscenario_id )
        REFERENCES changeintegrationscenario ( cis_id );
        
ALTER TABLE changeintegrationscenario
    ADD CONSTRAINT cis_changetype_fk FOREIGN KEY ( cis_changetype_id )
        REFERENCES types ( tp_id );
        
insert into changeintegrationscenario values (
    1,
    91,
    1,
    null,
    'CHT0000001'
);

insert into changeintegrationscenario values (
    2,
    91,
    2,
    1,
    'CHT0000001'
);

insert into changeintegrationscenario values (
    3,
    91,
    3,
    2,
    'CHT0000001'
);

insert into changeintegrationscenario values (
    4,
    91,
    3,
    null,
    'CHT0000001'
);

insert into changeintegrationscenario values (
    5,
    91,
    2,
    4,
    'CHT0000001'
);
