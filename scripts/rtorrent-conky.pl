#! /usr/bin/perl
 
use strict;
use warnings;
 
use Frontier::Client;
use Data::Dumper;
 
# Configuration
 
use constant server		=> 'http://joe@jdl55.ddns.net:80/rutorrent/plugins/httprpc/action.php';
use constant bt_stats	=> '/tmp/rtorrent_data';
 
# Do not edit below this comment
 
my $server = Frontier::Client->new(
	url      => server, 
	username =>'joe', 
	password =>'yardbird'
);
my $result = $server->call('d.multicall', "main", 
	"d.get_base_filename=",
	"d.get_bytes_done=",
	"d.get_size_bytes=",
	"to_kb=\$d.get_down_rate=");
 
open DATA, ">" . bt_stats;
 
my $idx = 1;
my @res;
foreach my $d (@$result) {
	my $cur = $d->[1];
	my $max = $d->[2];
	my $dl_rate = $d->[3];
	print DATA $cur/$max, "\n";
	push @res,
		sprintf("%.40s \${alignr}%7.1f KiB/s\$alignr\n" . 
			" " x 5 . "%3.2f%%" . "\${goto 70}\${execbar sed -ne '$idx p' " .
			bt_stats . '}', $d->[0], $dl_rate, 100 * $cur / $max);
	$idx++;
}
close DATA;
 
print join("\n\n", @res), "\n";
