
CREATE TABLE author (
    au_id         NUMBER(10) NOT NULL,
    au_username   VARCHAR2(100) NOT NULL,
    au_user_id    NUMBER(10)
);

ALTER TABLE author ADD CONSTRAINT author_pk PRIMARY KEY ( au_id );

CREATE TABLE change (
    ch_id                    NUMBER(10) NOT NULL,
    ch_changetype_id         VARCHAR2(10) NOT NULL,
    ch_statustype_id         VARCHAR2(10) NOT NULL,
    ch_metadataproperty_id   NUMBER(10),
    ch_dataitem_id           NUMBER(10),
    ch_mapping_id            NUMBER(10),
    ch_datahighwaylevel_id   NUMBER(10),
    ch_dataset_id            NUMBER(10),
    ch_author_id             NUMBER(10),
    ch_datasource_id         NUMBER(10),
    ch_relationship_id       NUMBER(10),
    ch_datetime              DATE NOT NULL,
    ch_description           VARCHAR2(4000),
    ch_attrname              VARCHAR2(50),
    ch_newattrvalue          VARCHAR2(4000),
    ch_oldattrvalue          VARCHAR2(4000)
);

ALTER TABLE change
    ADD CONSTRAINT change_ref_id_check CHECK ( DECODE(ch_metadataproperty_id, NULL, 0, 1) + DECODE(ch_dataitem_id, NULL, 0, 1) + DECODE
    (ch_mapping_id, NULL, 0, 1) + DECODE(ch_datahighwaylevel_id, NULL, 0, 1) + DECODE(ch_dataset_id, NULL, 0, 1) + DECODE(ch_datasource_id
    , NULL, 0, 1) + DECODE(ch_relationship_id, NULL, 0, 1) = 1 );

ALTER TABLE change ADD CONSTRAINT change_pk PRIMARY KEY ( ch_id );

CREATE TABLE datahighwaylevel (
    hl_id        NUMBER(10) NOT NULL,
    hl_name      VARCHAR2(100) NOT NULL,
    hl_created   DATE,
	hl_deleted 	 DATE
);

ALTER TABLE datahighwaylevel ADD CONSTRAINT datahighwaylevel_pk PRIMARY KEY ( hl_id );

CREATE TABLE dataitem (
    di_id            NUMBER(10) NOT NULL,
    di_name          VARCHAR2(100) NOT NULL,
    di_dataset_id    NUMBER(10) NOT NULL,
    di_itemtype_id   VARCHAR2(10) NOT NULL,
    di_role_id       VARCHAR2(10)
);

ALTER TABLE dataitem ADD CONSTRAINT dataitem_pk PRIMARY KEY ( di_id );

CREATE TABLE dataset (
    ds_id                    NUMBER(10) NOT NULL,
    ds_name                  VARCHAR2(100) NOT NULL,
    ds_description           VARCHAR2(4000),
    ds_frequency             VARCHAR2(100) NOT NULL,
    ds_datasource_id         NUMBER(10),
    ds_velocity_id           VARCHAR2(10) NOT NULL,
    ds_role_id               VARCHAR2(10),
    ds_datahighwaylevel_id   NUMBER(10),
    ds_formattype_id         VARCHAR2(10) NOT NULL,
    ds_created               DATE,
    ds_deleted               DATE
);

ALTER TABLE dataset ADD CONSTRAINT dataset_pk PRIMARY KEY ( ds_id );

CREATE TABLE datasetinstance (
    si_id            NUMBER(10) NOT NULL,
    si_dataset_id    NUMBER(10) NOT NULL,
    si_datetime      DATE NOT NULL,
    si_namepostfix   VARCHAR2(200)
);

ALTER TABLE datasetinstance ADD CONSTRAINT datasetinstance_pk PRIMARY KEY ( si_id );

CREATE TABLE datasource (
    so_id            NUMBER(10) NOT NULL,
    so_name          VARCHAR2(100) NOT NULL,
    so_description   VARCHAR2(4000),
    so_created       DATE,
    so_deleted       DATE
);

ALTER TABLE datasource ADD CONSTRAINT datasource_pk PRIMARY KEY ( so_id );

CREATE TABLE error_log (
    timestamp   TIMESTAMP NOT NULL,
    error       VARCHAR2(4000) NOT NULL
);

CREATE TABLE mapping (
    mp_id                   NUMBER(10) NOT NULL,
    mp_target_dataitem_id   NUMBER(10) NOT NULL,
    mp_operation            VARCHAR2(4000) NOT NULL
);

ALTER TABLE mapping ADD CONSTRAINT mapping_pk PRIMARY KEY ( mp_id );

CREATE TABLE mappingorigin (
    ms_mapping_id           NUMBER(10) NOT NULL,
    ms_origin_dataitem_id   NUMBER(10) NOT NULL,
    ms_order                NUMBER(10) NOT NULL
);

CREATE TABLE metadataproperty (
    md_id                    NUMBER(10) NOT NULL,
    md_name                  VARCHAR2(100) NOT NULL,
    md_value                 VARCHAR2(4000) NOT NULL,
    md_author_id             NUMBER(10),
    md_dataset_id            NUMBER(10),
    md_dataitem_id           NUMBER(10),
    md_mapping_id            NUMBER(10),
    md_datahighwaylevel_id   NUMBER(10),
    md_datasource_id         NUMBER(10),
    md_relationship_id       NUMBER(10),
    md_datasetinstance_id    NUMBER(10),
    md_created               DATE,
    md_deleted               DATE
);

ALTER TABLE metadataproperty ADD CONSTRAINT metadataproperty_pk PRIMARY KEY ( md_id );

CREATE TABLE relationship (
    rl_id                    NUMBER(10) NOT NULL,
    rl_parent_dataitem_id    NUMBER(10) NOT NULL,
    rl_relationshiptype_id   VARCHAR2(10) NOT NULL
);

ALTER TABLE relationship ADD CONSTRAINT relationship_pk PRIMARY KEY ( rl_id );

CREATE TABLE relationshipelement (
    re_child_dataitem_id   NUMBER(10) NOT NULL,
    re_relationship_id     NUMBER(10) NOT NULL
);

CREATE TABLE types (
    tp_id              VARCHAR2(10) NOT NULL,
    tp_type            VARCHAR2(4000) NOT NULL,
    tp_parenttype_id   VARCHAR2(10)
);

ALTER TABLE types ADD CONSTRAINT type_pk PRIMARY KEY ( tp_id );

CREATE TABLE user_tab (
    us_id         NUMBER(10) NOT NULL,
    us_name       VARCHAR2(50),
    us_email      VARCHAR2(250),
    us_password   VARCHAR2(100)
);

ALTER TABLE user_tab ADD CONSTRAINT user_pk PRIMARY KEY ( us_id );

ALTER TABLE author
    ADD CONSTRAINT author_user_fk FOREIGN KEY ( au_user_id )
        REFERENCES user_tab ( us_id );

ALTER TABLE change
    ADD CONSTRAINT ch_author_fk FOREIGN KEY ( ch_author_id )
        REFERENCES author ( au_id );

ALTER TABLE change
    ADD CONSTRAINT ch_changetype_fk FOREIGN KEY ( ch_changetype_id )
        REFERENCES types ( tp_id );

ALTER TABLE change
    ADD CONSTRAINT ch_datahighwaylevel_fk FOREIGN KEY ( ch_datahighwaylevel_id )
        REFERENCES datahighwaylevel ( hl_id );

ALTER TABLE change
    ADD CONSTRAINT ch_dataitem_fk FOREIGN KEY ( ch_dataitem_id )
        REFERENCES dataitem ( di_id );

ALTER TABLE change
    ADD CONSTRAINT ch_dataset_fk FOREIGN KEY ( ch_dataset_id )
        REFERENCES dataset ( ds_id );

ALTER TABLE change
    ADD CONSTRAINT ch_datasource_fk FOREIGN KEY ( ch_datasource_id )
        REFERENCES datasource ( so_id );

ALTER TABLE change
    ADD CONSTRAINT ch_mapping_fk FOREIGN KEY ( ch_mapping_id )
        REFERENCES mapping ( mp_id );

ALTER TABLE change
    ADD CONSTRAINT ch_metadataproperty_fk FOREIGN KEY ( ch_metadataproperty_id )
        REFERENCES metadataproperty ( md_id );

ALTER TABLE change
    ADD CONSTRAINT ch_relationship_fk FOREIGN KEY ( ch_relationship_id )
        REFERENCES relationship ( rl_id );

ALTER TABLE change
    ADD CONSTRAINT ch_statustype_fk FOREIGN KEY ( ch_statustype_id )
        REFERENCES types ( tp_id );

ALTER TABLE datasetinstance
    ADD CONSTRAINT datasetinstance_dataset_fk FOREIGN KEY ( si_dataset_id )
        REFERENCES dataset ( ds_id );

ALTER TABLE dataitem
    ADD CONSTRAINT di_dataset_fk FOREIGN KEY ( di_dataset_id )
        REFERENCES dataset ( ds_id );

ALTER TABLE dataitem
    ADD CONSTRAINT di_itemtype_fk FOREIGN KEY ( di_itemtype_id )
        REFERENCES types ( tp_id );

ALTER TABLE dataitem
    ADD CONSTRAINT di_roletype_fk FOREIGN KEY ( di_role_id )
        REFERENCES types ( tp_id );

ALTER TABLE dataset
    ADD CONSTRAINT ds_datahighwaylevel_fk FOREIGN KEY ( ds_datahighwaylevel_id )
        REFERENCES datahighwaylevel ( hl_id );

ALTER TABLE dataset
    ADD CONSTRAINT ds_datasource_fk FOREIGN KEY ( ds_datasource_id )
        REFERENCES datasource ( so_id );

ALTER TABLE dataset
    ADD CONSTRAINT ds_formattype_fk FOREIGN KEY ( ds_formattype_id )
        REFERENCES types ( tp_id );

ALTER TABLE dataset
    ADD CONSTRAINT ds_roletype_fk FOREIGN KEY ( ds_role_id )
        REFERENCES types ( tp_id );

ALTER TABLE dataset
    ADD CONSTRAINT ds_velocitytype_fk FOREIGN KEY ( ds_velocity_id )
        REFERENCES types ( tp_id );

ALTER TABLE metadataproperty
    ADD CONSTRAINT md_author_fk FOREIGN KEY ( md_author_id )
        REFERENCES author ( au_id );

ALTER TABLE metadataproperty
    ADD CONSTRAINT md_datahighwaylevel_fk FOREIGN KEY ( md_datahighwaylevel_id )
        REFERENCES datahighwaylevel ( hl_id );

ALTER TABLE metadataproperty
    ADD CONSTRAINT md_dataitem_fk FOREIGN KEY ( md_dataitem_id )
        REFERENCES dataitem ( di_id );

ALTER TABLE metadataproperty
    ADD CONSTRAINT md_dataset_fk FOREIGN KEY ( md_dataset_id )
        REFERENCES dataset ( ds_id );

ALTER TABLE metadataproperty
    ADD CONSTRAINT md_datasetinstance_fk FOREIGN KEY ( md_datasetinstance_id )
        REFERENCES datasetinstance ( si_id );

ALTER TABLE metadataproperty
    ADD CONSTRAINT md_datasource_fk FOREIGN KEY ( md_datasource_id )
        REFERENCES datasource ( so_id );

ALTER TABLE metadataproperty
    ADD CONSTRAINT md_mapping_fk FOREIGN KEY ( md_mapping_id )
        REFERENCES mapping ( mp_id );

ALTER TABLE metadataproperty
    ADD CONSTRAINT md_relationship_fk FOREIGN KEY ( md_relationship_id )
        REFERENCES relationship ( rl_id );

ALTER TABLE mapping
    ADD CONSTRAINT mp_target_dataitem_fk FOREIGN KEY ( mp_target_dataitem_id )
        REFERENCES dataitem ( di_id );

ALTER TABLE mappingorigin
    ADD CONSTRAINT ms_dataitem_fk FOREIGN KEY ( ms_origin_dataitem_id )
        REFERENCES dataitem ( di_id );

ALTER TABLE mappingorigin
    ADD CONSTRAINT ms_mapping_fk FOREIGN KEY ( ms_mapping_id )
        REFERENCES mapping ( mp_id );

ALTER TABLE relationshipelement
    ADD CONSTRAINT re_child_dataitem_fk FOREIGN KEY ( re_child_dataitem_id )
        REFERENCES dataitem ( di_id );

ALTER TABLE relationshipelement
    ADD CONSTRAINT re_relationship_fk FOREIGN KEY ( re_relationship_id )
        REFERENCES relationship ( rl_id );

ALTER TABLE relationship
    ADD CONSTRAINT rl_parent_dataitem_fk FOREIGN KEY ( rl_parent_dataitem_id )
        REFERENCES dataitem ( di_id );

ALTER TABLE relationship
    ADD CONSTRAINT rl_relationshiptype_fk FOREIGN KEY ( rl_relationshiptype_id )
        REFERENCES types ( tp_id );

ALTER TABLE types
    ADD CONSTRAINT tp_type_fk FOREIGN KEY ( tp_parenttype_id )
        REFERENCES types ( tp_id );

CREATE SEQUENCE author_au_id_seq START WITH 1 NOCACHE ORDER;

CREATE SEQUENCE change_ch_id_seq START WITH 1 NOCACHE ORDER;

CREATE SEQUENCE datahighwaylevel_hl_id_seq START WITH 1 NOCACHE ORDER;

CREATE SEQUENCE dataitem_di_id_seq START WITH 1 NOCACHE ORDER;

CREATE SEQUENCE dataset_ds_id_seq START WITH 1 NOCACHE ORDER;

CREATE SEQUENCE datasetinstance_si_id_seq START WITH 1 NOCACHE ORDER;

CREATE SEQUENCE datasource_so_id_seq START WITH 1 NOCACHE ORDER;

CREATE SEQUENCE mapping_mp_id_seq START WITH 1 NOCACHE ORDER;

CREATE SEQUENCE metadataproperty_md_id_seq START WITH 1 NOCACHE ORDER;

CREATE SEQUENCE relationship_rl_id_seq START WITH 1 NOCACHE ORDER;

CREATE SEQUENCE user_tab_us_id_seq START WITH 1 NOCACHE ORDER;


create table XML_NODES_COPY (
ID NUMBER(10) NOT NULL,
PREV number(10),
NAME VARCHAR2(250 BYTE),
TYP VARCHAR2(250 BYTE),
SPEC VARCHAR2(250 BYTE)
)

