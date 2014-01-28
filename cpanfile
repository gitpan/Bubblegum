requires "Class::Forward" => "0.100006";
requires "Class::Load" => "0";
requires "DateTime::Tiny" => "1.04";
requires "Exception::Tiny" => "0";
requires "Exporter::Tiny" => "0.030";
requires "File::Find::Rule" => "0";
requires "File::HomeDir" => "1.00";
requires "File::Which" => "1.09";
requires "Import::Into" => "1.001001";
requires "JSON::Tiny" => "0.38";
requires "Module::Find" => "0.11";
requires "Moo" => "1.003001";
requires "Path::Tiny" => "0.047";
requires "Syntax::Keyword::Junction" => "0.003007";
requires "Time::Format" => "1.12";
requires "Time::ParseDate" => "2013.1113";
requires "Try::Tiny" => "0.18";
requires "Type::Tiny" => "0.032";
requires "YAML::Tiny" => "1.56";
requires "autobox" => "0";
requires "autodie" => "0";
requires "perl" => "v5.10.0";
requires "utf8::all" => "0";

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "6.30";
};

on 'develop' => sub {
  requires "Test::CPAN::Changes" => "0.19";
};
