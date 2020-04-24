insert into changeadaptationoperation values (2, 'COP0000001', 'Describe the new structure in metadata.');
insert into changeadaptationoperation values (3, 'COP0000001', 'Implement the new structure.');
insert into changeadaptationoperation values (4, 'COP0000001', 'Define ELT processes in mapping metadata.');

insert into changeadaptationcondition values (1, 'If a new data source is needed', 'CON0000002');

insert into changeadaptationoperation values (5, 'COP0000001', 'Add dataset examples.');

insert into changeadaptationcondition values (2, 'change_adaptation.dataset_example_added', 'CON0000001');

insert into changeadaptationoperation values (6, 'COP0000002', 'change_adaptation.get_dataset_structure');
insert into changeadaptationoperation values (7, 'COP0000002', 'change_adaptation.add_dataset_to_datahighwaylevel');


insert into changeadaptationscenario values (2, 2, null, 'CHT0000013');
insert into changeadaptationscenario values (3, 3, 2, 'CHT0000013');
insert into changeadaptationscenario values (4, 4, 3, 'CHT0000013');


insert into changeadaptationscenario values (5, 5, 4, 'CHT0000013');
insert into ca_conditionmapping values (1, 5, 1);

insert into changeadaptationscenario values (6, 6, 5, 'CHT0000013');
insert into ca_conditionmapping values (2, 6, 1);
insert into ca_conditionmapping values (4, 6, 2);

insert into changeadaptationscenario values (7, 7, 6, 'CHT0000013');
insert into ca_conditionmapping values (3, 7, 1);
insert into ca_conditionmapping values (5, 7, 2);



