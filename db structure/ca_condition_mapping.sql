CREATE TABLE CA_Condition_mapping (
    cacm_id                    NUMBER(10) NOT NULL,
    cacm_scenario_id           number(10) not null,
    cacm_condition_id          number(10)
);


ALTER TABLE CA_Condition_mapping ADD CONSTRAINT cond_mapping_pk PRIMARY KEY ( cacm_id );

ALTER TABLE CA_Condition_mapping
    ADD CONSTRAINT cacm_scenario_fk FOREIGN KEY ( cacm_scenario_id )
        REFERENCES changeadaptationscenario ( cas_id );
        
ALTER TABLE CA_Condition_mapping
    ADD CONSTRAINT cacm_condition_fk FOREIGN KEY ( cacm_condition_id )
        REFERENCES changeadaptationcondition ( cac_id );


insert into CA_Condition_mapping values (1, 5, 1);