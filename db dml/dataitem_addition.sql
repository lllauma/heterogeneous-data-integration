insert into changeadaptationcondition values (5, 'If data item needs to be added to a data set' ,'CON0000002');
insert into changeadaptationcondition values (6, 'If data item needs to be added to a data set of a data source' ,'CON0000002');
insert into changeadaptationcondition values (7, 'change_adaptation.dataitem_example_added' ,'CON0000001');

insert into changeadaptationoperation values (11, 'COP0000001', 'Define data set');
insert into changeadaptationoperation values (12, 'COP0000001', 'Add data item examples');
insert into changeadaptationoperation values (13, 'COP0000002', 'change_adaptation.get_dataitem_structure');
insert into changeadaptationoperation values (14, 'COP0000002', 'change_adaptation.add_dataitem_to_dataset');

insert into changeadaptationscenario values (19, 2, null, 'CHT0000012');
insert into changeadaptationscenario values (20, 11, 19, 'CHT0000012');
insert into changeadaptationscenario values (21, 4, 20, 'CHT0000012');
insert into changeadaptationscenario values (22, 5, 21, 'CHT0000012');
insert into changeadaptationscenario values (23, 6, 22, 'CHT0000012');
insert into changeadaptationscenario values (24, 9, 23, 'CHT0000012');
insert into changeadaptationscenario values (25, 10, 24, 'CHT0000012');
insert into changeadaptationscenario values (26, 4, 25, 'CHT0000012');

insert into changeadaptationscenario values (27, 12, null, 'CHT0000012');
insert into changeadaptationscenario values (28, 13, 27, 'CHT0000012');
insert into changeadaptationscenario values (29, 14, 28, 'CHT0000012');

insert into ca_conditionmapping values (28, 19, 5);
insert into ca_conditionmapping values (29, 20, 5);
insert into ca_conditionmapping values (30, 21, 5);
insert into ca_conditionmapping values (31, 22, 5);
insert into ca_conditionmapping values (32, 23, 5);
insert into ca_conditionmapping values (33, 24, 5);
insert into ca_conditionmapping values (34, 25, 5);
insert into ca_conditionmapping values (35, 26, 5);

insert into ca_conditionmapping values (36, 22, 1);
insert into ca_conditionmapping values (37, 23, 1);
insert into ca_conditionmapping values (38, 24, 1);
insert into ca_conditionmapping values (39, 25, 1);
insert into ca_conditionmapping values (40, 26, 1);

insert into ca_conditionmapping values (41, 23, 2);
insert into ca_conditionmapping values (42, 24, 2);
insert into ca_conditionmapping values (43, 25, 2);
insert into ca_conditionmapping values (44, 26, 2);

insert into ca_conditionmapping values (45, 27, 6);
insert into ca_conditionmapping values (46, 28, 6);
insert into ca_conditionmapping values (47, 29, 6);

insert into ca_conditionmapping values (48, 28, 7);
insert into ca_conditionmapping values (49, 29, 7);

