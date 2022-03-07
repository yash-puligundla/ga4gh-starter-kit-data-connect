/* ################################################## */
/* # PHENOPACKET                                       # */
/* ################################################## */

CREATE TABLE IF NOT EXISTS phenopacket
(   
    id text PRIMARY KEY
);

/* ################################################## */
/* # ONTOLOGY CLASS                                     # */
/* ################################################## */

CREATE TABLE IF NOT EXISTS ontology_class
(   
    id text PRIMARY KEY,
    label text NOT NULL   
);

/* ################################################## */
/* # TIME ELEMENT                                      # */
/* ################################################## */

CREATE TABLE IF NOT EXISTS time_element
(   
    id text PRIMARY KEY,
    gestational_age_weeks integer,
    gestational_age_days integer,
    age_iso8601duration text,
    age_range_end_iso8601duration text,
    time_element_timestamp timestamp,
    interval_start_timestamp timestamp,
    interval_end_timestamp timestamp,
    fk_time_element_ontology_class text
    foreign key (fk_time_element_ontology_class) references ontology_class(id),
);

/* ################################################## */
/* # SUBJECT                                        # */
/* ################################################## */

CREATE TABLE IF NOT EXISTS subject
(
    id text PRIMARY KEY,
    dateofbirth timestamp without time zone,
    sex text,
    karyotypic_sex text,
    gender text,
    fk_phenopacket_subject text,
    fk_subject_time_at_last_encounter integer,
    fk_subject_vital_status_status_time_of_death integer,
    fk_subject_taxonomy text,
    foreign key (fk_phenopacket_subject) references phenopacket(id),
    foreign key (fk_subject_time_at_last_encounter) references time_element(id),
    foreign key (fk_subject_vital_status_status_time_of_death) references time_element(id),
    foreign key (fk_subject_taxonomy) references ontology_class(id)
);

CREATE TABLE IF NOT EXISTS curie
(
    id integer PRIMARY KEY AUTOINCREMENT,
    curie text NOT NULL,
    fk_subject_alternate_ids text,
    foreign key (fk_subject_alternate_ids) references subject(id),
);

CREATE TABLE IF NOT EXISTS vital_status
(
    id integer PRIMARY KEY AUTOINCREMENT,
    status text NOT NULL,
    survival_time_in_days integer,
    fk_subject_vital_status text,
    fk_vital_status_cause_of_death text,
    foreign key (fk_subject_vital_status) references subject(id),
    foreign key (fk_vital_status_cause_of_death) references ontology_class(id)
);

/* ################################################## */
/* # PHENOTYPIC FEATURE                                      # */
/* ################################################## */

CREATE TABLE IF NOT EXISTS phenotypic_feature
(
    id uuid PRIMARY KEY,
    description text,
    excluded boolean DEFAULT false,
    fk_biosample_phenotypic_features text,
    fk_phenopacket_phenotypic_feature text,
    fk_phenotypic_feature_onset integer,
    fk_phenotypic_feature_resolution integer,
    fk_phenotypic_feature_type text,
    fk_phenotypic_feature_severity text,
    --later after biosample foreign key (fk_biosample_phenotypic_features) references biosample(id),
    foreign key (fk_phenopacket_phenotypic_feature) references phenopacket(id),
    foreign key (fk_phenotypic_feature_onset) references time_element(id),
    foreign key (fk_phenotypic_feature_resolution) references time_element(id),
    foreign key (fk_phenotypic_feature_type) references ontology_class(id),
    foreign key (fk_phenotypic_feature_severity) references ontology_class(id)
    );

CREATE TABLE IF NOT EXISTS evidence
(
    id integer PRIMARY KEY AUTOINCREMENT,
    fk_evidence_external_reference integer,
    fk_evidence_ontology_class text,
    --later after external_references foreign key (fk_evidence_external_reference) references external_references(id),
    foreign key (fk_evidence_ontology_class) references ontology_class(id)
);

/* ################################################## */
/* # MEASUREMENT                                     # */
/* ################################################## */

CREATE TABLE IF NOT EXISTS measurement
(
    id uuid PRIMARY KEY,
    description text,
    fk_biosample_measurement text,
    fk_phenopacket_measurement text,
    fk_measurement_time_observed integer,
    fk_measurement_assay text,
    --later after biosample foreign key (fk_biosample_measurement) references biosample(id),
    foreign key (fk_phenopacket_measurement) references phenopacket(id),
    foreign key (fk_measurement_time_observed) references time_element(id),
    foreign key (fk_measurement_assay) references ontology_class(id)
);

-- TODO: pick up from here

CREATE TABLE IF NOT EXISTS value
(
    id integer PRIMARY KEY AUTOINCREMENT,
    fk_measurement_value_value
    fk_value_quantity
    fk_value_ontology_class


);

CREATE TABLE IF NOT EXISTS complex_value
(
    id integer PRIMARY KEY AUTOINCREMENT,
    fk_measurement_value_complex_value
    fk_complex_value_quantity
    fk_complex_value_type


);

CREATE TABLE IF NOT EXISTS procedure
(
    id integer PRIMARY KEY AUTOINCREMENT,
    fk_biosample_procedure
    fk_medical_action_action
    fk_procedure_code


);












