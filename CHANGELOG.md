# Change Log

All notable changes to this project will be documented in this file.

<a name="unreleased"></a>
## [Unreleased]



<a name="v4.3.0"></a>
## [v4.3.0] - 2021-06-28

- feat: Add rules for SMTP, SMTPS, SaltStack ([#220](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/220))


<a name="v4.2.0"></a>
## [v4.2.0] - 2021-05-27

- feat: Create group optionally ([#218](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/218))


<a name="v4.1.0"></a>
## [v4.1.0] - 2021-05-27

- chore: Fixed GH actions to be the same as in other terraform-aws-modules ([#217](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/217))
- chore: Updated versions in README


<a name="v4.0.0"></a>
## [v4.0.0] - 2021-04-26

- feat: Shorten outputs (removing this_) ([#210](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/210))
- chore: update documentation and pin `terraform_docs` version to avoid future changes ([#208](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/208))
- chore: add ci-cd workflow for pre-commit checks ([#206](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/206))


<a name="v3.18.0"></a>
## [v3.18.0] - 2021-02-20

- chore: update documentation based on latest `terraform-docs` which includes module and resource sections ([#205](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/205))


<a name="v3.17.0"></a>
## [v3.17.0] - 2020-11-13

- feat: Adding LDAP into rules.tf ([#195](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/195))


<a name="v3.16.0"></a>
## [v3.16.0] - 2020-08-20

- chore: Fixed formatting
- feat: Allow custom Name tag for security group ([#187](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/187))


<a name="v3.15.0"></a>
## [v3.15.0] - 2020-08-13

- feat: Add JMX and Node exporter TCP ports for Kafka ([#186](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/186))


<a name="v3.14.0"></a>
## [v3.14.0] - 2020-08-13

- feat: aws-provider version bump to >= 2.42, < 4.0 ([#184](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/184))


<a name="v3.13.0"></a>
## [v3.13.0] - 2020-07-20

- feat: Add support for Solr ([#181](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/181))


<a name="v3.12.0"></a>
## [v3.12.0] - 2020-07-03

- feat: Added optional revoke_rules_on_delete functionality (required for EMR) ([#179](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/179))


<a name="v3.11.0"></a>
## [v3.11.0] - 2020-06-24

- feat: Updated version requirements to support Terraform 0.13 ([#178](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/178))


<a name="v3.10.0"></a>
## [v3.10.0] - 2020-05-13

- fix: Fixed MinIO rules formatting
- feat: Adding support for MinIO ([#174](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/174))


<a name="v3.9.0"></a>
## [v3.9.0] - 2020-05-11

- feat: Adding support for prometheus and alertmanager ([#173](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/173))


<a name="v3.8.0"></a>
## [v3.8.0] - 2020-04-20

- Updated README
- feat: Added support for kibana dashboard - 5601-tcp ([#170](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/170))


<a name="v3.7.0"></a>
## [v3.7.0] - 2020-04-17

- docs: Fixed README after merge
- feat: Added support for graphite-statsd stack ([#169](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/169))


<a name="v3.6.0"></a>
## [v3.6.0] - 2020-04-16

- chore: Autoformatting fixes after merge
- fix: Don't use var.(in|e)gress_ipv6_cidr_blocks on security group sourced (in|e)gress ([#148](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/148))
- chore: Updated comment with correct UDP protocol number (fixes [#137](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/137))


<a name="v3.5.0"></a>
## [v3.5.0] - 2020-04-16

- fix: Set requirements for AWS provider and Terraform
- fix: Add Kafka broker rule for TLS port ([#155](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/155))
- feat: Added support of grafana dashboard - 3000-tcp ([#167](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/167))
- feat: Added support of kubernetes api server - 6443-tcp ([#166](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/166))


<a name="v3.4.0"></a>
## [v3.4.0] - 2020-01-21

- Updated pre-commit-terraform with terraform-docs 0.8.0 support ([#153](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/153))


<a name="v3.3.0"></a>
## [v3.3.0] - 2020-01-07

- Empty the known issues section + pre-commit ([#150](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/150))


<a name="v3.2.0"></a>
## [v3.2.0] - 2019-11-14

- Updated pre-commit hooks
- Add ActiveMQ rules ([#143](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/143))


<a name="v3.1.0"></a>
## [v3.1.0] - 2019-07-21

- Fix Splunk Web ([#132](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/132))
- Updated terraform_docs pre-commit hook


<a name="v3.0.1"></a>
## [v3.0.1] - 2019-05-27

- Fixed computed example in README ([#122](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/122))


<a name="v3.0.0"></a>
## [v3.0.0] - 2019-05-26

- Upgrade module to support Terraform 0.12 ([#120](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/120))


<a name="v2.17.0"></a>
## [v2.17.0] - 2019-04-26

- Added puppet as auto_group
- Add rule for PuppetDB TCP ([#113](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/113))


<a name="v2.16.0"></a>
## [v2.16.0] - 2019-03-21

- Updated README after [#110](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/110)
- add rabbitmq discovery epmd port 4369 ([#110](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/110))


<a name="v2.15.0"></a>
## [v2.15.0] - 2019-03-08

- Fixed rabbitmq port (closes [#107](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/107))


<a name="v2.14.0"></a>
## [v2.14.0] - 2019-02-17

- Updated docs after [#104](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/104)
- add rules for MongoDB cluster ports


<a name="v2.13.0"></a>
## [v2.13.0] - 2019-02-06

- Run pre-commit
- add rule for rabbitmq


<a name="v2.12.0"></a>
## [v2.12.0] - 2019-02-06

- Run pre-commit
- add name rule for mongodb


<a name="v2.11.0"></a>
## [v2.11.0] - 2019-01-17

- Added http-8080 and https-8443 ports
- Added entry for 8443 ([#98](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/98))


<a name="v2.10.0"></a>
## [v2.10.0] - 2018-12-28

- Allow use_name_prefix override in submodules ([#95](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/95))


<a name="v2.9.0"></a>
## [v2.9.0] - 2018-10-17

- Fixed README after terraform-docs


<a name="v2.8.0"></a>
## [v2.8.0] - 2018-10-17

- Add a rule for consul CLI RPC ([#83](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/83))


<a name="v2.7.0"></a>
## [v2.7.0] - 2018-10-11

- Added missing files for ntp rules
- Added NTP rule ([#71](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/71))


<a name="v2.6.0"></a>
## [v2.6.0] - 2018-10-11

- Fixed formatting
- Extended Splunk module to includ HEC ([#81](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/81))


<a name="v2.5.0"></a>
## [v2.5.0] - 2018-09-12

- Cleanup after [#74](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/74)
- Make use of name_prefix optional ([#74](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/74))


<a name="v2.4.0"></a>
## [v2.4.0] - 2018-09-05

- Using name_prefix instead of name to allow creation of duplicated with create_before_destroy (fix [#40](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/40))


<a name="v2.3.0"></a>
## [v2.3.0] - 2018-09-04

- Added lifecycle create_before_destroy on aws_security_group (fixed [#40](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/40))


<a name="v2.2.0"></a>
## [v2.2.0] - 2018-08-23

- Added squid to auto_groups and ran update_groups.sh
- Add squid proxy to rules.tf ([#70](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/70))
- Fix source of predefined rule example ([#69](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/69))


<a name="v2.1.0"></a>
## [v2.1.0] - 2018-06-20

- Evaluate var.create variable to set count to 1 or 0 ([#62](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/62))


<a name="v2.0.0"></a>
## [v2.0.0] - 2018-05-29

- README fixes
- README fixes
- Merge remote-tracking branch 'origin/computed_values'
- Fix to allow computed values in arguments ([#61](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/61))
- Fix to allow computed values in arguments


<a name="v1.25.0"></a>
## [v1.25.0] - 2018-05-17

- Ran pre-commit hook to get formatting and documentation in place
- Added WinRM Ports ([#60](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/60))


<a name="v1.24.0"></a>
## [v1.24.0] - 2018-05-16

- Added pre-commit hook to autogenerate terraform-docs ([#59](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/59))


<a name="v1.23.0"></a>
## [v1.23.0] - 2018-05-14

- Added dynamic example ([#57](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/57))


<a name="v1.22.0"></a>
## [v1.22.0] - 2018-04-23

- Not ignore changes in rules description ([#52](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/52))


<a name="v1.21.0"></a>
## [v1.21.0] - 2018-04-17

- Adds Oracle database port ([#51](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/51))


<a name="v1.20.0"></a>
## [v1.20.0] - 2018-03-06

- Updated links in readme files


<a name="v1.19.0"></a>
## [v1.19.0] - 2018-03-02

- Removed readme from private module


<a name="v1.18.0"></a>
## [v1.18.0] - 2018-03-02

- Added README to all modules ([#45](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/45))


<a name="v1.17.0"></a>
## [v1.17.0] - 2018-03-02

- Added Splunk ports ([#44](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/44))


<a name="v1.16.0"></a>
## [v1.16.0] - 2018-03-02

- Fix openvpn rule name mismatch ([#43](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/43))


<a name="v1.15.0"></a>
## [v1.15.0] - 2018-02-08

- added rdp-udp, fixed typo in mssql-broker-tcp ([#37](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/37))


<a name="v1.14.0"></a>
## [v1.14.0] - 2018-02-05

- Added pre-commit and minor update of version in readme


<a name="v1.13.0"></a>
## [v1.13.0] - 2018-01-19

- Adding RDP and updating MSSQL service ports. ([#35](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/35))


<a name="v1.12.0"></a>
## [v1.12.0] - 2018-01-16

- Workaround for bug when updating description of a rule with protocol all ([#34](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/34))


<a name="v1.11.1"></a>
## [v1.11.1] - 2018-01-16

- cosmetics ([#33](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/33))


<a name="v1.11.0"></a>
## [v1.11.0] - 2018-01-12

- Revert "Specify minimum required version of AWS provider ([#30](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/30))" ([#32](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/32))


<a name="v1.10.0"></a>
## [v1.10.0] - 2018-01-11

- Specify minimum required version of AWS provider ([#30](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/30))


<a name="v1.9.0"></a>
## [v1.9.0] - 2018-01-10

- Fixed redshift by running update_rules script
- Add redshift tcp port ([#24](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/24))


<a name="v1.8.0"></a>
## [v1.8.0] - 2018-01-10

- Add support for Rule descriptions with a safe default value ([#27](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/27))


<a name="v1.7.0"></a>
## [v1.7.0] - 2018-01-10

- Add NFS tcp port ([#28](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/28))


<a name="v1.6.0"></a>
## [v1.6.0] - 2017-11-24

- Fixed formatting
- Add IPSEC to rules.tf ([#23](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/23))


<a name="v1.5.1"></a>
## [v1.5.1] - 2017-11-23

- formatting to help downstream depedent modules pass when running CI ([#22](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/22))


<a name="v1.5.0"></a>
## [v1.5.0] - 2017-11-20

- Removed outputs of ingress and egress rules, because of complex types


<a name="v1.4.0"></a>
## [v1.4.0] - 2017-11-16

- Fixed outputs when security group is not created


<a name="v1.3.0"></a>
## [v1.3.0] - 2017-11-15

- Added possibility to create resources conditionally ([#20](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/20))


<a name="v1.2.2"></a>
## [v1.2.2] - 2017-11-15

- Fixed autogenerated templates to include ipv6 rules also ([#19](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/19))


<a name="v1.2.1"></a>
## [v1.2.1] - 2017-11-13

- Update README with calculated variable limitation ([#18](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/18))


<a name="v1.2.0"></a>
## [v1.2.0] - 2017-11-03

- Make IPV6 really optional ([#15](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/15))


<a name="v1.1.4"></a>
## [v1.1.4] - 2017-10-26

- Merge branch 'master' of github.com:Shapeways/terraform-aws-security-group
- Add Puppet to rules.tf


<a name="v1.1.3"></a>
## [v1.1.3] - 2017-10-20

- Add DNS udp and tcp to rules.


<a name="v1.1.2"></a>
## [v1.1.2] - 2017-10-14

- Fixed all-icmp ports (closes [#7](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/7))


<a name="v1.1.1"></a>
## [v1.1.1] - 2017-10-11

- Update default all-all rule


<a name="v1.1.0"></a>
## [v1.1.0] - 2017-10-06

- Removed default cidr for ingress rules, fixed self variable name


<a name="v1.0.0"></a>
## v1.0.0 - 2017-10-04

- Fixed [#1](https://github.com/terraform-aws-modules/terraform-aws-security-group/issues/1) - done
- Initial commit


[Unreleased]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v4.3.0...HEAD
[v4.3.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v4.2.0...v4.3.0
[v4.2.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v4.1.0...v4.2.0
[v4.1.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v4.0.0...v4.1.0
[v4.0.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v3.18.0...v4.0.0
[v3.18.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v3.17.0...v3.18.0
[v3.17.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v3.16.0...v3.17.0
[v3.16.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v3.15.0...v3.16.0
[v3.15.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v3.14.0...v3.15.0
[v3.14.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v3.13.0...v3.14.0
[v3.13.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v3.12.0...v3.13.0
[v3.12.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v3.11.0...v3.12.0
[v3.11.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v3.10.0...v3.11.0
[v3.10.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v3.9.0...v3.10.0
[v3.9.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v3.8.0...v3.9.0
[v3.8.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v3.7.0...v3.8.0
[v3.7.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v3.6.0...v3.7.0
[v3.6.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v3.5.0...v3.6.0
[v3.5.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v3.4.0...v3.5.0
[v3.4.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v3.3.0...v3.4.0
[v3.3.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v3.2.0...v3.3.0
[v3.2.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v3.1.0...v3.2.0
[v3.1.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v3.0.1...v3.1.0
[v3.0.1]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v3.0.0...v3.0.1
[v3.0.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v2.17.0...v3.0.0
[v2.17.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v2.16.0...v2.17.0
[v2.16.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v2.15.0...v2.16.0
[v2.15.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v2.14.0...v2.15.0
[v2.14.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v2.13.0...v2.14.0
[v2.13.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v2.12.0...v2.13.0
[v2.12.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v2.11.0...v2.12.0
[v2.11.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v2.10.0...v2.11.0
[v2.10.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v2.9.0...v2.10.0
[v2.9.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v2.8.0...v2.9.0
[v2.8.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v2.7.0...v2.8.0
[v2.7.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v2.6.0...v2.7.0
[v2.6.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v2.5.0...v2.6.0
[v2.5.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v2.4.0...v2.5.0
[v2.4.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v2.3.0...v2.4.0
[v2.3.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v2.2.0...v2.3.0
[v2.2.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v2.1.0...v2.2.0
[v2.1.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v2.0.0...v2.1.0
[v2.0.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.25.0...v2.0.0
[v1.25.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.24.0...v1.25.0
[v1.24.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.23.0...v1.24.0
[v1.23.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.22.0...v1.23.0
[v1.22.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.21.0...v1.22.0
[v1.21.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.20.0...v1.21.0
[v1.20.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.19.0...v1.20.0
[v1.19.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.18.0...v1.19.0
[v1.18.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.17.0...v1.18.0
[v1.17.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.16.0...v1.17.0
[v1.16.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.15.0...v1.16.0
[v1.15.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.14.0...v1.15.0
[v1.14.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.13.0...v1.14.0
[v1.13.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.12.0...v1.13.0
[v1.12.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.11.1...v1.12.0
[v1.11.1]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.11.0...v1.11.1
[v1.11.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.10.0...v1.11.0
[v1.10.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.9.0...v1.10.0
[v1.9.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.8.0...v1.9.0
[v1.8.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.7.0...v1.8.0
[v1.7.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.6.0...v1.7.0
[v1.6.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.5.1...v1.6.0
[v1.5.1]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.5.0...v1.5.1
[v1.5.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.4.0...v1.5.0
[v1.4.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.3.0...v1.4.0
[v1.3.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.2.2...v1.3.0
[v1.2.2]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.2.1...v1.2.2
[v1.2.1]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.2.0...v1.2.1
[v1.2.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.1.4...v1.2.0
[v1.1.4]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.1.3...v1.1.4
[v1.1.3]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.1.2...v1.1.3
[v1.1.2]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.1.1...v1.1.2
[v1.1.1]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.1.0...v1.1.1
[v1.1.0]: https://github.com/terraform-aws-modules/terraform-aws-security-group/compare/v1.0.0...v1.1.0
