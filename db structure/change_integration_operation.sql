CREATE TABLE changeintegrationoperation (
    cio_id                    NUMBER(10) NOT NULL,
    cio_operationtype_id      VARCHAR2(10 BYTE) not null,
    cio_operation             VARCHAR2(4000) not null
);

ALTER TABLE changeintegrationoperation ADD CONSTRAINT integration_pk PRIMARY KEY ( cio_id );

ALTER TABLE changeintegrationoperation
    ADD CONSTRAINT cio_operationtype_fk FOREIGN KEY ( cio_operationtype_id )
        REFERENCES types ( tp_id );
        


insert into changeintegrationoperation values (
    1,
    'COP0000001',
    'Define the new structure metadata.'
);

insert into changeintegrationoperation values (
    2,
    'COP0000001',
    'Implement the new structure.'
);

insert into changeintegrationoperation values (
    3,
    'COP0000001',
    'Implement ELT processes in mapping metadata.'
);
insert into changeintegrationoperation values (
    4,
    'COP0000002',
    'Get the new structure metadata.'
);
insert into changeintegrationoperation values (
    5,
    'COP0000001',
    'Add dataset examples.'
);