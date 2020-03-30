CREATE TABLE CI_Condition_mapping (
    cicm_id                    NUMBER(10) NOT NULL,
    cicm_scenario_id           number(10) not null,
    cicm_condition_id          number(10)
);


ALTER TABLE CI_Condition_mapping ADD CONSTRAINT cond_mapping_pk PRIMARY KEY ( cicm_id );

ALTER TABLE CI_Condition_mapping
    ADD CONSTRAINT cicm_scenario_fk FOREIGN KEY ( cicm_scenario_id )
        REFERENCES changeintegrationscenario ( cis_id );
        
ALTER TABLE CI_Condition_mapping
    ADD CONSTRAINT cicm_condition_fk FOREIGN KEY ( cicm_condition_id )
        REFERENCES changeintegrationcondition ( cic_id );


insert into CI_Condition_mapping values (1, 5, 1);