CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- CREATE Tables

CREATE TABLE organizations (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE users (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  organization_id uuid REFERENCES organizations(id),
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE services (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  organization_id uuid REFERENCES organizations(id),
  name VARCHAR(255) NOT NULL,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE versions (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  service_id uuid REFERENCES services(id),
  version VARCHAR(255) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- CREATE Indexes

CREATE INDEX ON services (name);
CREATE INDEX ON services (description);
CREATE INDEX ON services (created_at);

CREATE INDEX ON versions (service_id);
CREATE INDEX ON versions (version);


-- ADD Data

INSERT INTO organizations (name, description) VALUES ('Marelli', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac nunc nec odio tincidunt aliquam. Sed nec nunc nec odio tincidunt aliquam.');
INSERT INTO organizations (name, description) VALUES ('Bosch', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac nunc nec odio tincidunt aliquam. Sed nec nunc nec odio tincidunt aliquam.');

INSERT INTO users (organization_id, name, email, password) VALUES ((SELECT id FROM organizations WHERE name = 'Marelli'), 'John Doe', 'john.doe@mail.com', '');
INSERT INTO users (organization_id, name, email, password) VALUES ((SELECT id FROM organizations WHERE name = 'Bosch'), 'Jane Doe', 'jane.doe@mail.com', '');

INSERT INTO services (name, description, organization_id) VALUES ('Locate Us', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac nunc nec odio tincidunt aliquam. Sed nec nunc nec odio tincidunt aliquam.', (SELECT id FROM organizations WHERE name = 'Marelli'));
INSERT INTO services (name, description, organization_id) VALUES ('Collect Monday', '', (SELECT id FROM organizations WHERE name = 'Marelli'));
INSERT INTO services (name, description, organization_id) VALUES ('Contact Us', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac nunc nec odio tincidunt aliquam. Sed nec nunc nec odio tincidunt aliquam.', (SELECT id FROM organizations WHERE name = 'Marelli'));
INSERT INTO services (name, description, organization_id) VALUES ('About Us', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac nunc nec odio tincidunt aliquam. Sed nec nunc nec odio tincidunt aliquam.', (SELECT id FROM organizations WHERE name = 'Marelli'));
INSERT INTO services (name, description, organization_id) VALUES ('FX Rate International', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac nunc nec odio tincidunt aliquam. Sed nec nunc nec odio tincidunt aliquam.', (SELECT id FROM organizations WHERE name = 'Marelli'));
INSERT INTO services (name, description, organization_id) VALUES ('FX Rate Local', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac nunc nec odio tincidunt aliquam. Sed nec nunc nec odio tincidunt aliquam.', (SELECT id FROM organizations WHERE name = 'Marelli'));
INSERT INTO services (name, description, organization_id) VALUES ('FX Rate', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac nunc nec odio tincidunt aliquam. Sed nec nunc nec odio tincidunt aliquam.', (SELECT id FROM organizations WHERE name = 'Marelli'));
INSERT INTO services (name, description, organization_id) VALUES ('FX Rate Calculator', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac nunc nec odio tincidunt aliquam. Sed nec nunc nec odio tincidunt aliquam.', (SELECT id FROM organizations WHERE name = 'Marelli'));
INSERT INTO services (name, description, organization_id) VALUES ('FX Rate Converter', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac nunc nec odio tincidunt aliquam. Sed nec nunc nec odio tincidunt aliquam.', (SELECT id FROM organizations WHERE name = 'Marelli'));
INSERT INTO services (name, description, organization_id) VALUES ('Notifications', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac nunc nec odio tincidunt aliquam. Sed nec nunc nec odio tincidunt aliquam.', (SELECT id FROM organizations WHERE name = 'Marelli'));
INSERT INTO services (name, description, organization_id) VALUES ('News', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac nunc nec odio tincidunt aliquam. Sed nec nunc nec odio tincidunt aliquam.', (SELECT id FROM organizations WHERE name = 'Bosch'));
INSERT INTO services (name, description, organization_id) VALUES ('Priority Issues', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac nunc nec odio tincidunt aliquam. Sed nec nunc nec odio tincidunt aliquam.', (SELECT id FROM organizations WHERE name = 'Bosch'));
INSERT INTO services (name, description, organization_id) VALUES ('Feedback', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac nunc nec odio tincidunt aliquam. Sed nec nunc nec odio tincidunt aliquam.', (SELECT id FROM organizations WHERE name = 'Bosch'));
INSERT INTO services (name, description, organization_id) VALUES ('Reporting', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac nunc nec odio tincidunt aliquam. Sed nec nunc nec odio tincidunt aliquam.', (SELECT id FROM organizations WHERE name = 'Bosch'));
INSERT INTO services (name, description, organization_id) VALUES ('Security', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac nunc nec odio tincidunt aliquam. Sed nec nunc nec odio tincidunt aliquam.', (SELECT id FROM organizations WHERE name = 'Bosch'));

INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Locate Us'), '1.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Locate Us'), '1.0.1');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Locate Us'), '1.0.2');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Locate Us'), '1.11.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Locate Us'), '1.12.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Locate Us'), '2.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Locate Us'), '2.1.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Locate Us'), '2.2.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Locate Us'), '2.3.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Locate Us'), '2.4.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Locate Us'), '2.5.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Locate Us'), '2.6.0');

INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Collect Monday'), '1.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Collect Monday'), '1.0.1');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Collect Monday'), '1.0.2');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Collect Monday'), '1.0.3');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Collect Monday'), '1.0.4');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Collect Monday'), '1.0.5');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Collect Monday'), '1.0.6');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Collect Monday'), '1.0.7');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Collect Monday'), '1.0.8');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Collect Monday'), '1.0.9');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Collect Monday'), '1.0.10');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Collect Monday'), '1.12.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Collect Monday'), '2.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Collect Monday'), '2.1.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Collect Monday'), '2.2.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Collect Monday'), '2.3.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Collect Monday'), '3.0.0');

INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Contact Us'), '1.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Contact Us'), '2.0.1');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Contact Us'), '2.0.2');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Contact Us'), '2.0.3');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Contact Us'), '3.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Contact Us'), '3.0.1');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Contact Us'), '4.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Contact Us'), '4.0.1');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Contact Us'), '4.0.2');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Contact Us'), '5.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Contact Us'), '5.0.1');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Contact Us'), '5.0.2');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Contact Us'), '5.0.3');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Contact Us'), '5.1.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Contact Us'), '5.1.1');

INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'About Us'), '1.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'About Us'), '1.0.1');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'About Us'), '1.0.2');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'About Us'), '1.0.3');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'About Us'), '1.0.4');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'About Us'), '1.0.5');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'About Us'), '1.0.6');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'About Us'), '2.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'About Us'), '2.0.1');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'About Us'), '2.1.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'About Us'), '2.2.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'About Us'), '2.3.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'About Us'), '2.4.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'About Us'), '3.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'About Us'), '3.1.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'About Us'), '3.2.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'About Us'), '3.3.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'About Us'), '3.4.0');

INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '1.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '1.0.1');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '1.0.2');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '1.0.3');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '1.0.4');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '1.0.5');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '1.1.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '1.2.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '1.3.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '1.4.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '1.5.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '1.6.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '1.7.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '1.8.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '1.9.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '1.10.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '1.11.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '1.12.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '2.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '2.1.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '2.2.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '2.3.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '2.4.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '2.5.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '2.6.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '2.7.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '2.8.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '2.9.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '2.10.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '2.11.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '2.12.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '3.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '3.1.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '3.2.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '3.3.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '3.4.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '3.5.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '4.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '4.1.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '4.2.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '4.2.1');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '4.2.2');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '5.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '5.1.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '5.2.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '5.3.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate International'), '5.4.0');

INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '1.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '1.0.1');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '1.0.2');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '1.0.3');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '1.0.4');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '1.0.5');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '1.1.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '1.2.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '1.3.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '1.4.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '1.5.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '1.6.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '1.7.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '1.8.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '1.9.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '1.10.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '1.11.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '1.12.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '2.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '2.1.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '3.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '3.0.1');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '3.0.2');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '3.0.3');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '3.0.4');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '3.0.5');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '3.1.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '3.2.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '3.3.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '3.4.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '3.5.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '3.6.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '3.7.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '3.8.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '3.9.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '3.10.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '3.11.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '3.12.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '4.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '4.0.1');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '4.0.2');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '4.0.3');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '4.0.4');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '4.0.5');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '4.1.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '4.2.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '4.3.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '4.4.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '4.5.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '4.6.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '4.7.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '4.8.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '4.9.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '4.10.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '4.11.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Local'), '4.12.0');

INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate'), '1.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate'), '1.0.1');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate'), '1.0.2');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate'), '1.0.3');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate'), '1.0.4');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate'), '1.1.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate'), '1.2.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate'), '1.3.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate'), '1.4.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate'), '1.5.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate'), '1.6.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate'), '1.7.0');

INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Calculator'), '1.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'FX Rate Converter'), '1.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Notifications'), '1.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'News'), '1.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Priority Issues'), '1.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Feedback'), '1.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Reporting'), '1.0.0');
INSERT INTO versions (service_id, version) VALUES ((SELECT id FROM services WHERE name = 'Security'), '1.0.0');
