CREATE TABLE changeintegrationoperation (
    cio_id                    NUMBER(10) NOT NULL,
    cio_operationtype_id      VARCHAR2(10 BYTE) not null,
    cio_operation             VARCHAR2(4000) not null
);

ALTER TABLE changeintegrationoperation ADD CONSTRAINT integration_pk PRIMARY KEY ( cio_id );

ALTER TABLE changeintegrationoperation
    ADD CONSTRAINT cio_operationtype_fk FOREIGN KEY ( cio_operationtype_id )
        REFERENCES types ( tp_id );
        
INSERT INTO types VALUES (
    'COP0000000',
    'Change integration operation type',
    NULL
);

INSERT INTO types VALUES (
    'COP0000001',
    'Manual',
    'COP0000000'
);

INSERT INTO types VALUES (
    'COP0000002',
    'Automatic',
    'COP0000000'
);

insert into changeintegrationoperation values (
    1,
    'COP0000001',
    'Describe new data highway level structure in metadata'
);

insert into changeintegrationoperation values (
    2,
    'COP0000001',
    'Create data structure in data warehouse'
);

insert into changeintegrationoperation values (
    3,
    'COP0000001',
    'Define ELT processes in metadata'
);