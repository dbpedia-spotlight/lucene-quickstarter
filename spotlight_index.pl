#!/usr/bin/perl -w
$num_args = $#ARGV + 1;
if ($num_args != 3) {
  print "\nUsage: perl spotlight_index.pl memory language_i18n language\n";
  print "\n E.g for English: spotlight_index.pl 14g en english\n";
  exit;
}

$memory=$ARGV[0];
$lang_i18n=$ARGV[1];
$language=$ARGV[2];
system('JAVA_XMX='.$memory);
system('lang_i18n='.$lang_i18n);
system('language='.$language);
system("./scripts/index.sh");

