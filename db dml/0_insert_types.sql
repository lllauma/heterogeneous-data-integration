INSERT INTO types VALUES (
    'DST0000000',
    'Data set type',
    NULL
);

INSERT INTO types VALUES (
    'DST0000001',
    'Structured data set',
    'DST0000000'
);

INSERT INTO types VALUES (
    'DST0000002',
    'Semi-structured data set',
    'DST0000000'
);

INSERT INTO types VALUES (
    'DST0000003',
    'Unstructured data set',
    'DST0000000'
);

INSERT INTO types VALUES (
    'FMT0000000',
    'Format type',
    'DST0000000'
);

INSERT INTO types VALUES (
    'FMT0000011',
    'XML',
    'DST0000002'
);

INSERT INTO types VALUES (
    'FMT0000012',
    'JSON',
    'DST0000002'
);

INSERT INTO types VALUES (
    'FMT0000013',
    'CSV',
    'DST0000002'
);

INSERT INTO types VALUES (
    'FMT0000014',
    'HTML',
    'DST0000002'
);

INSERT INTO types VALUES (
    'FMT0000015',
    'Excel',
    'DST0000002'
);

INSERT INTO types VALUES (
    'FMT0000016',
    'Key-Value',
    'DST0000002'
);

INSERT INTO types VALUES (
    'FMT0000017',
    'RDF',
    'DST0000002'
);

INSERT INTO types VALUES (
    'FMT0000021',
    'Text',
    'DST0000003'
);

INSERT INTO types VALUES (
    'FMT0000022',
    'Image',
    'DST0000003'
);

INSERT INTO types VALUES (
    'FMT0000023',
    'Video',
    'DST0000003'
);

INSERT INTO types VALUES (
    'FMT0000024',
    'Sensor',
    'DST0000003'
);

INSERT INTO types VALUES (
    'FMT0000025',
    'Geospatial',
    'DST0000003'
);

INSERT INTO types VALUES (
    'FMT0000031',
    'Relational',
    'DST0000001'
);

INSERT INTO types VALUES (
    'VLT0000000',
    'Velocity type',
    NULL
);

INSERT INTO types VALUES (
    'VLT0000001',
    'Batch',
    'VLT0000000'
);

INSERT INTO types VALUES (
    'VLT0000002',
    'Near real-time',
    'VLT0000000'
);

INSERT INTO types VALUES (
    'VLT0000003',
    'Real-time',
    'VLT0000000'
);

INSERT INTO types VALUES (
    'VLT0000004',
    'Stream',
    'VLT0000000'
);

INSERT INTO types VALUES (
    'DSR0000000',
    'Data set role',
    NULL
);

INSERT INTO types VALUES (
    'DSR0000001',
    'Data warehouse dimension',
    'DSR0000000'
);

INSERT INTO types VALUES (
    'DSR0000002',
    'Data warehouse fact table',
    'DSR0000000'
);

INSERT INTO types VALUES (
    'DIR0000000',
    'Data item role',
    NULL
);

INSERT INTO types VALUES (
    'DIR0000001',
    'Data warehouse dimension attribute',
    'DIR0000000'
);

INSERT INTO types VALUES (
    'DIR0000002',
    'Data warehouse measure',
    'DIR0000000'
);

INSERT INTO types VALUES (
    'DIT0000000',
    'Data item type',
    NULL
);

INSERT INTO types VALUES (
    'DIT0000001',
    'Column',
    'DIT0000000'
);

INSERT INTO types VALUES (
    'DIT0000002',
    'Element',
    'DIT0000000'
);

INSERT INTO types VALUES (
    'DIT0000003',
    'Attribute',
    'DIT0000000'
);

INSERT INTO types VALUES (
    'DIT0000004',
    'Object',
    'DIT0000000'
);

INSERT INTO types VALUES (
    'DIT0000005',
    'Array',
    'DIT0000000'
);

INSERT INTO types VALUES (
    'DIT0000006',
    'Text block',
    'DIT0000000'
);

INSERT INTO types VALUES (
    'DIT0000007',
    'Key',
    'DIT0000000'
);

INSERT INTO types VALUES (
    'STT0000000',
    'Status type',
    NULL
);

INSERT INTO types VALUES (
    'STT0000001',
    'New',
    'STT0000000'
);

INSERT INTO types VALUES (
    'STT0000002',
    'In progress',
    'STT0000000'
);

INSERT INTO types VALUES (
    'STT0000003',
    'Processed',
    'STT0000000'
);

INSERT INTO types VALUES (
    'CHT0000000',
    'Change type',
    NULL
);

INSERT INTO types VALUES (
    'CHT0000001',
    'Addition',
    'CHT0000000'
);

INSERT INTO types VALUES (
    'CHT0000002',
    'Deletion',
    'CHT0000000'
);

INSERT INTO types VALUES (
    'CHT0000003',
    'Metadata value update',
    'CHT0000000'
);

INSERT INTO types VALUES (
    'RLT0000000',
    'Relationship type',
    NULL
);

INSERT INTO types VALUES (
    'RLT0000001',
    'Composition',
    'RLT0000000'
);

INSERT INTO types VALUES (
    'RLT0000002',
    'Foreign key',
    'RLT0000000'
);

INSERT INTO types VALUES (
    'RLT0000003',
    'Predicate',
    'RLT0000000'
);
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

insert into types values ('MPR0000000', 'Pre-defined metadata property', null);
insert into types values ('MPR0000001', 'DATA_TYPE', 'MPR0000000');
insert into types values ('MPR0000002', 'DATA_LENGTH', 'MPR0000000');
insert into types values ('MPR0000003', 'DATA_PRECISION', 'MPR0000000');
insert into types values ('MPR0000004', 'DATA_SCALE', 'MPR0000000');
insert into types values ('MPR0000005', 'NULLABLE', 'MPR0000000');



insert into types values ('CHT0000011', 'Metadata property addition', 'CHT0000001');
insert into types values ('CHT0000012', 'Data item addition', 'CHT0000001');
insert into types values ('CHT0000013', 'Data highway level addition', 'CHT0000001');
insert into types values ('CHT0000014', 'Data set addition', 'CHT0000001');
insert into types values ('CHT0000015', 'Data source addition', 'CHT0000001');

insert into types values ('CHT0000021', 'Metadata property deletion', 'CHT0000002');
insert into types values ('CHT0000022', 'Data item deletion', 'CHT0000002');
insert into types values ('CHT0000023', 'Data highway level deletion', 'CHT0000002');
insert into types values ('CHT0000024', 'Data set deletion', 'CHT0000002');

insert into types values ('CHT0000031', 'Metadata value update', 'CHT0000003');

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
