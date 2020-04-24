insert into changeadaptationcondition values (3, 'If data set needs to be added to a data highway level' ,'CON0000002');
insert into changeadaptationcondition values (4, 'If data set needs to be added to a data source' ,'CON0000002');

insert into changeadaptationoperation values (8, 'COP0000001', 'Define data highway level');
insert into changeadaptationoperation values (9, 'COP0000002', 'change_adaptation.add_dataset_to_1st_datahighwaylevel');
insert into changeadaptationoperation values (10, 'COP0000001', 'Define other data highway levels');

insert into changeadaptationscenario values (8, 2, null, 'CHT0000014');
insert into changeadaptationscenario values (9, 8, 8, 'CHT0000014');
insert into changeadaptationscenario values (10, 4, 9, 'CHT0000014');
insert into changeadaptationscenario values (11, 5, 10, 'CHT0000014');
insert into changeadaptationscenario values (12, 6, 11, 'CHT0000014');
insert into changeadaptationscenario values (13, 9, 12, 'CHT0000014');
insert into changeadaptationscenario values (14, 10, 13, 'CHT0000014');
insert into changeadaptationscenario values (15, 4, 14, 'CHT0000014');

insert into changeadaptationscenario values (16, 5, null, 'CHT0000014');
insert into changeadaptationscenario values (17, 6, 16, 'CHT0000014');
insert into changeadaptationscenario values (18, 9, 17, 'CHT0000014');

insert into ca_conditionmapping values (6, 8, 3);
insert into ca_conditionmapping values (7, 9, 3);
insert into ca_conditionmapping values (8, 10, 3);
insert into ca_conditionmapping values (9, 11, 3);
insert into ca_conditionmapping values (10, 12, 3);
insert into ca_conditionmapping values (11, 13, 3);
insert into ca_conditionmapping values (12, 14, 3);
insert into ca_conditionmapping values (13, 15, 3);

insert into ca_conditionmapping values (14, 11, 1);
insert into ca_conditionmapping values (15, 12, 1);
insert into ca_conditionmapping values (16, 13, 1);
insert into ca_conditionmapping values (17, 14, 1);
insert into ca_conditionmapping values (18, 15, 1);

insert into ca_conditionmapping values (19, 16, 4);
insert into ca_conditionmapping values (20, 17, 4);
insert into ca_conditionmapping values (21, 18, 4);

insert into ca_conditionmapping values (22, 12, 2);
insert into ca_conditionmapping values (23, 13, 2);
insert into ca_conditionmapping values (24, 14, 2);
insert into ca_conditionmapping values (25, 15, 2);

insert into ca_conditionmapping values (26, 17, 2);
insert into ca_conditionmapping values (27, 18, 2);

