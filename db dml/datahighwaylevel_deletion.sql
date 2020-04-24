insert into changeadaptationcondition values (8 ,'change_adaptation.exist_related_datasets' ,'CON0000001');
insert into changeadaptationcondition values (9, 'change_adaptation.related_datasets_datasources_available' ,'CON0000001');
insert into changeadaptationcondition values (10, 'change_adaptation.related_datasets_datasources_not_available','CON0000001');
insert into changeadaptationcondition values (11, 'If there is an option to replace data source with data from another data sources','CON0000002');
insert into changeadaptationcondition values (12, 'If there is data which can not be replaced from another data sources','CON0000002');
insert into changeadaptationcondition values (13, 'If there is no option to replace data source with data from another data sources','CON0000002');
insert into changeadaptationcondition values (14, 'change_adaptation.alternative_data_sources_added','CON0000001');

insert into changeadaptationoperation values (15, 'COP0000001', 'Change ELT processes in mapping metadata');
insert into changeadaptationoperation values (16, 'COP0000001', 'Define alternative data sources');
insert into changeadaptationoperation values (17, 'COP0000002', 'change_adaptation.set_alternative_data_sources');

insert into changeadaptationscenario values (30, 15, null, 'CHT0000023');

insert into changeadaptationscenario values (31, 5, null, 'CHT0000023');
insert into changeadaptationscenario values (32, 6, 31, 'CHT0000023');
insert into changeadaptationscenario values (33, 9, 32, 'CHT0000023');
insert into changeadaptationscenario values (34, 10, 33, 'CHT0000023');
insert into changeadaptationscenario values (35, 4, 34, 'CHT0000023');
insert into changeadaptationscenario values (36, 16, 35, 'CHT0000023');
insert into changeadaptationscenario values (37, 17, 36, 'CHT0000023');
insert into changeadaptationscenario values (38, 15, 37, 'CHT0000023');

insert into changeadaptationscenario values (39, 15, null, 'CHT0000023');

insert into ca_conditionmapping values (50, 30, 8);
insert into ca_conditionmapping values (51, 31, 8);
insert into ca_conditionmapping values (52, 32, 8);
insert into ca_conditionmapping values (53, 33, 8);
insert into ca_conditionmapping values (54, 34, 8);
insert into ca_conditionmapping values (55, 35, 8);
insert into ca_conditionmapping values (56, 36, 8);
insert into ca_conditionmapping values (57, 37, 8);
insert into ca_conditionmapping values (58, 38, 8);
insert into ca_conditionmapping values (59, 39, 8);

insert into ca_conditionmapping values (60, 30, 9);

insert into ca_conditionmapping values (61, 31, 10);
insert into ca_conditionmapping values (62, 32, 10);
insert into ca_conditionmapping values (63, 33, 10);
insert into ca_conditionmapping values (64, 34, 10);
insert into ca_conditionmapping values (65, 35, 10);
insert into ca_conditionmapping values (66, 36, 10);
insert into ca_conditionmapping values (67, 37, 10);
insert into ca_conditionmapping values (68, 38, 10);
insert into ca_conditionmapping values (69, 39, 10);

insert into ca_conditionmapping values (70, 31, 11);
insert into ca_conditionmapping values (71, 32, 11);
insert into ca_conditionmapping values (72, 33, 11);
insert into ca_conditionmapping values (73, 34, 11);
insert into ca_conditionmapping values (74, 35, 11);
insert into ca_conditionmapping values (75, 36, 11);
insert into ca_conditionmapping values (76, 37, 11);
insert into ca_conditionmapping values (77, 38, 11);

insert into ca_conditionmapping values (78, 31, 1);
insert into ca_conditionmapping values (79, 32, 1);
insert into ca_conditionmapping values (80, 33, 1);
insert into ca_conditionmapping values (81, 34, 1);
insert into ca_conditionmapping values (82, 35, 1);

insert into ca_conditionmapping values (83, 32, 2);
insert into ca_conditionmapping values (84, 33, 2);
insert into ca_conditionmapping values (85, 34, 2);
insert into ca_conditionmapping values (86, 35, 2);

insert into ca_conditionmapping values (87, 38, 12);

insert into ca_conditionmapping values (88, 39, 13);

insert into ca_conditionmapping values (89, 37, 14);

