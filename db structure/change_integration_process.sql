CREATE TABLE changeintegrationprocess (
    cip_id                    NUMBER(10) NOT NULL,
    cip_scenario_id           number(10) not null,
    cip_datetime              timestamp not null,
    cip_author_id             number(10,0) not null,
    cip_statustype_id         VARCHAR2(10 BYTE) not null,
    cip_change_id             number(10) not null
);

ALTER TABLE changeintegrationprocess ADD CONSTRAINT process_pk PRIMARY KEY ( cip_id );

ALTER TABLE changeintegrationprocess
    ADD CONSTRAINT cip_scenario_fk FOREIGN KEY ( cip_scenario_id )
        REFERENCES changeintegrationscenario ( cis_id );
        
ALTER TABLE changeintegrationprocess
    ADD CONSTRAINT cip_author_fk FOREIGN KEY ( cip_author_id )
        REFERENCES author ( AU_ID );
        
ALTER TABLE changeintegrationprocess
    ADD CONSTRAINT cip_statustype_fk FOREIGN KEY ( cip_statustype_id )
        REFERENCES types ( tp_id );
        
ALTER TABLE changeintegrationprocess
    ADD CONSTRAINT cip_change_fk FOREIGN KEY ( cip_change_id )
        REFERENCES change ( ch_id );

INSERT INTO types VALUES (
    'CIP0000000',
    'Change integration operation status type',
    NULL
);

INSERT INTO types VALUES (
    'CIP0000001',
    'Not integrated',
    'CIP0000000'
);

INSERT INTO types VALUES (
    'CIP0000002',
    'Integrated',
    'CIP0000000'
);
