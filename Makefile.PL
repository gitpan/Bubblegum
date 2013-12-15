
use strict;
use warnings;

use 5.010000;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Opinionated Modern Perl Development Framework",
  "AUTHOR" => "Al Newkirk <anewkirk\@ana.io>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Bubblegum",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Bubblegum",
  "PREREQ_PM" => {
    "Class::Forward" => "0.100006",
    "Class::Load" => 0,
    "DateTime::Tiny" => "1.04",
    "Exception::Tiny" => 0,
    "Exporter::Tiny" => "0.030",
    "File::Find::Rule" => 0,
    "File::HomeDir" => "1.00",
    "File::Which" => "1.09",
    "Import::Into" => "1.001001",
    "JSON::Tiny" => "0.38",
    "Module::Find" => "0.11",
    "Moo" => "1.003001",
    "Path::Tiny" => "0.047",
    "Time::Format" => "1.12",
    "Time::ParseDate" => "2013.1113",
    "Try::Tiny" => "0.18",
    "Type::Tiny" => "0.032",
    "YAML::Tiny" => "1.56",
    "autobox" => 0,
    "autodie" => 0,
    "utf8::all" => 0
  },
  "TEST_REQUIRES" => {},
  "VERSION" => "0.01",
  "test" => {
    "TESTS" => "t/*.t t/bubblegum/*.t t/bubblegum/object/*.t t/bubblegum/object/role/*.t t/bubblegum/role/*.t t/bubblegum/wrapper/*.t"
  }
);


my %FallbackPrereqs = (
  "Class::Forward" => "0.100006",
  "Class::Load" => 0,
  "DateTime::Tiny" => "1.04",
  "Exception::Tiny" => 0,
  "Exporter::Tiny" => "0.030",
  "File::Find::Rule" => 0,
  "File::HomeDir" => "1.00",
  "File::Which" => "1.09",
  "Import::Into" => "1.001001",
  "JSON::Tiny" => "0.38",
  "Module::Find" => "0.11",
  "Moo" => "1.003001",
  "Path::Tiny" => "0.047",
  "Time::Format" => "1.12",
  "Time::ParseDate" => "2013.1113",
  "Try::Tiny" => "0.18",
  "Type::Tiny" => "0.032",
  "YAML::Tiny" => "1.56",
  "autobox" => 0,
  "autodie" => 0,
  "utf8::all" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



