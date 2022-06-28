SET check_function_bodies = false;
CREATE SCHEMA userschema;
CREATE TABLE public.calendar (
    datefield date NOT NULL
);
CREATE TABLE userschema.employee (
    empid integer NOT NULL,
    name text NOT NULL,
    age integer NOT NULL
);
CREATE SEQUENCE userschema.employee_empid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE userschema.employee_empid_seq OWNED BY userschema.employee.empid;
CREATE TABLE userschema.holiday (
    id integer NOT NULL,
    name text NOT NULL
);
CREATE TABLE userschema.leaves (
    leavid integer NOT NULL,
    type text NOT NULL,
    empid integer NOT NULL,
    orgid integer NOT NULL
);
CREATE TABLE userschema.org_emp (
    orgid integer NOT NULL,
    empid integer NOT NULL,
    role text NOT NULL
);
CREATE TABLE userschema.organization (
    orgid integer NOT NULL,
    orgname text NOT NULL,
    empid integer NOT NULL,
    createdat date NOT NULL
);
CREATE SEQUENCE userschema.organization_orgid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE userschema.organization_orgid_seq OWNED BY userschema.organization.orgid;
CREATE TABLE userschema.setting (
    "settingId" uuid NOT NULL,
    "settingName" text NOT NULL
);
CREATE TABLE userschema."user" (
    "userId" integer NOT NULL,
    name text NOT NULL,
    profileimage text DEFAULT 'image'::text,
    email text
);
ALTER TABLE ONLY userschema.employee ALTER COLUMN empid SET DEFAULT nextval('userschema.employee_empid_seq'::regclass);
ALTER TABLE ONLY userschema.organization ALTER COLUMN orgid SET DEFAULT nextval('userschema.organization_orgid_seq'::regclass);
ALTER TABLE ONLY public.calendar
    ADD CONSTRAINT calendar_pkey PRIMARY KEY (datefield);
ALTER TABLE ONLY userschema.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (empid);
ALTER TABLE ONLY userschema.holiday
    ADD CONSTRAINT holiday_pkey PRIMARY KEY (id);
ALTER TABLE ONLY userschema.leaves
    ADD CONSTRAINT leaves_pkey PRIMARY KEY (leavid);
ALTER TABLE ONLY userschema.org_emp
    ADD CONSTRAINT org_emp_pkey PRIMARY KEY (orgid, empid);
ALTER TABLE ONLY userschema.organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (orgid);
ALTER TABLE ONLY userschema.setting
    ADD CONSTRAINT setting_pkey PRIMARY KEY ("settingId");
ALTER TABLE ONLY userschema."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY ("userId");
ALTER TABLE ONLY userschema.leaves
    ADD CONSTRAINT leaves_empid_fkey FOREIGN KEY (empid) REFERENCES userschema.employee(empid) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY userschema.leaves
    ADD CONSTRAINT leaves_orgid_fkey FOREIGN KEY (orgid) REFERENCES userschema.organization(orgid) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY userschema.org_emp
    ADD CONSTRAINT org_emp_empid_fkey FOREIGN KEY (empid) REFERENCES userschema.employee(empid) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY userschema.org_emp
    ADD CONSTRAINT org_emp_orgid_fkey FOREIGN KEY (orgid) REFERENCES userschema.organization(orgid) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY userschema.organization
    ADD CONSTRAINT organization_empid_fkey FOREIGN KEY (empid) REFERENCES userschema.employee(empid) ON UPDATE RESTRICT ON DELETE RESTRICT;
