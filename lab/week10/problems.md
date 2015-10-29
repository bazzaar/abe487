# Install LWP

    $ cpanm MIME::Base64
    $ cpanm LWP

# Install Bio::Perl

    $ cpanm --look Bio::Perl
    $ perl Build.PL
    $ ./Build install

NB: The command "cpanm --look" downloads the module, unpacks it, and 
then creates a new shell inside the distribution directory.  When you 
are finished, press ctrl-D to exit the shell.  If for some reason you
are not in the newly create distribution directory, cd to there.

After running "perl Build.PL," accept all defaults, esp. allowing
BioPerl to install sample scripts, then go into your "~/perl5/bin" dir
and have a look.

Try one:

    bp_fetch.pl net::genbank:JX295726
    >gi|401879637|gb|JX295726.1| Lucilia sericata voucher LucilNICC0392 cytochrome oxidase subunit 1 (COI) gene, partial cds; mitochondrial
    TCGCAACAATGGTTATTTTCAACTAATCATAAAGATATTGGAACTTTATATTTTATTTTT
    GGAGCTTGATCCGGAATAATTGGAACTTCTTTAAGAATTCTAATTCGAGCTGAATTAGGA
    CATCCTGGAGCTTTAATTGGAGATGATCAAATTTATAATGTAATTGTTACAGCTCATGCT
    TTTATTATAATTTTTTTTATAGTAATGCCAATTATAATTGGAGGATTTGGAAATTGATTA
    GTTCCATTAATACTAGGAGCTCCAGATATAGCATTCCCTCGAATAAATAATATAAGTTTT
    TGACTTTTACCTCCTGCATTAACTTTATTATTAGTTAGTAGTATAGTAGAAAACGGAGCT
    GGAACAGGATGAACAGTTTACCCTCCTCTATCTTCTAATATTGCTCATGGAGGAGCTTCT
    GTTGATTTAGCTATTTTCTCTCTTCATTTAGCAGGAATTTCTTCAATTTTAGGAGCTGTA
    AATTTTATTACTACAGTTATTAATATACGATCAACAGGAATTACTTTTGATCGAATACCT
    TTATTTGTTTGATCAGTAGTAATTACAGCTTTATTACTTTTATTATCATTACCAGTATTA
    GCAGGAGCTATTACAATACTTTTAACAGACCGAAATCTTAATACATCATTCTTTGACCCT
    GCAGGAGGAGGAGATCCAATTTTATACCAACATTTATTTTGATTCTTTGGACACCCT

# Problems

## 01-find-ids.pl

Download/gunzip "uniprot_sprot" using the Unix command "wget":

    $ wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz
    $ gunzip uniprot_sprot.fasta.gz

Write a script to retrieve all IDs from a FASTA file matching a given 
pattern, e.g.:

    $ ./01-find-ids.pl
    Usage: 01-find-ids.pl FASTA pattern

For later scripts, you will need to search for "HDAC" in 
"uniprot_sprot.fasta."  You will probably want to use the 
"get_all_primary_ids" method from "Bio::DB::Fasta."  
(Check out the BioPerl Deobfuscator for more information.)

Print the sequences for these proteins, in FASTA format, to a 
file like "<pattern>.fa."  You will need to get rid of any non-word
characters from the pattern before using it as a filename (hint:
use a regular expression with the s// command).

    $ ./01-find-ids.pl uniprot_sprot.fasta HDAC
    Searching 'uniprot_sprot.fasta' for 'HDAC'
    sp|Q8C2B3|HDAC7_MOUSE
    sp|Q6GPA7|HDAC8_XENLA
    sp|B1WC68|HDAC8_RAT
    sp|Q28DV3|HDAC3_XENTR
    sp|Q5RAG0|HDAC1_PONAB
    sp|B1H369|HDAC8_XENTR
    sp|Q5ZKH6|HDAC9_CHICK
    sp|P56524|HDAC4_HUMAN
    sp|Q94517|HDAC1_DROME
    sp|P56519|HDAC2_CHICK
    sp|Q6P6W3|HDAC3_RAT
    sp|O15379|HDAC3_HUMAN
    sp|P70288|HDAC2_MOUSE
    sp|Q9Z2V5|HDAC6_MOUSE
    sp|Q5R902|HDAC5_PONAB
    sp|O88895|HDAC3_MOUSE
    sp|Q99P99|HDAC4_RAT
    sp|Q8WUI4|HDAC7_HUMAN
    sp|Q9Z2V6|HDAC5_MOUSE
    sp|Q4QQW4|HDAC1_RAT
    sp|P56520|HDAC3_CHICK
    sp|Q13547|HDAC1_HUMAN
    sp|Q9YGY4|HDAC9_XENLA
    sp|O09106|HDAC1_MOUSE
    sp|P56517|HDAC1_CHICK
    sp|Q9BY41|HDAC8_HUMAN
    sp|Q6NZM9|HDAC4_MOUSE
    sp|Q92769|HDAC2_HUMAN
    sp|Q80ZH1|HDAC5_CRIGR
    sp|Q9UQL6|HDAC5_HUMAN
    sp|Q8VH37|HDAC8_MOUSE
    sp|Q803C3|HDAC3_DANRE
    sp|Q9UKV0|HDAC9_HUMAN
    sp|Q99P96|HDAC7_RAT
    sp|Q9UBN7|HDAC6_HUMAN
    sp|P56518|HDAC1_STRPU
    sp|Q99N13|HDAC9_MOUSE
    sp|P83038|HDAC4_CHICK
    sp|Q7SXM0|HDAC8_DANRE
    sp|Q6IRL9|HDAC3_XENLA
    sp|Q4SFA0|HDAC3_TETNG
    sp|Q32PJ8|HDAC1_BOVIN
    sp|Q5RB76|HDAC3_PONAB
    sp|Q0VCB2|HDAC8_BOVIN
    Found 44 ids
    See results in 'HDAC.fa'

## 02-cds.pl

Bio::SeqIO

Download a GenBank record, e.g.:

    http://www.ncbi.nlm.nih.gov/nuccore/NM_001286260.1

Or use the "sequence.gb" record from here.

Write a script using Bio::SeqIO to retrieve the CDS translation from a 
Genbank file, e.g.:

    $ ./02-cds.pl sequence.gb
    MDNFGLGGSDLSKGQIFQVLVRLSVASLITYYSVKWMMNQMDPTSKNKKKAKVLAEEQLKRLAEQEGFKLRGQEFSDYELMIASHLVVPADITVSWADIAGLDSVIQELRESVVLPIQHKDLFKHSKLWQAPKGVLLHGPPGCGKTLIAKATAKEAGMRFINLDVAILTDKWYGESQKLTSAVFSLASRIEPCIIFIDEIDSFLRSRNMNDHEATAMMKTQFMMLWDGLSTNANSTVIVMGATNRPQDLDKAIVRRMPAQFHIGLPSETQRKDILKLILQSEEVSQDVDLNRLSKLTNGFSGSDLREMCRNASVYRMRQLITSRDPSATALDRNNVRITMDDLLGSHLKIKESKMHTSSLFLENRIELD
    $ ./02-cds.pl Nfat5.gb
    MPSDFISLLSADLDLESPKSLYSRESVYDLLPKELQLPPPRETSVASMSQTSGGEAGSPPPAVVAADASSAPSSSSMGGACSSFTTSSSPTIYSTSVTDSKAMQVESCSSAVGVSNRGVSEKQLTGNTVQQHPSTPKRHTVLYISPPPEDLLDNSRMSCQDEGCGLESEQSCSMWMEDSPSNFSNMSTSSYNDNTEVPRKSRKRNPKQRPGVKRRDCEESNMDIFDADSAKAPHYVLSQLTTDNKGNSKAGNGTLDSQKGTGVKKSPMLCGQYPVKSEGKELKIVVQPETQHRARYLTEGSRGSVKDRTQQGFPTVKLEGHNEPVVLQVFVGNDSGRVKPHGFYQACRVTGRNTTPCKEVDIEGTTVIEVGLDPSNNMTLAVDCVGILKLRNADVEARIGIAGSKKKSTRARLVFRVNITRKDGSTLTLQTPSSPILCTQPAGVPEILKKSLHSCSVKGEEEVFLIGKNFLKGTKVIFQENVSDENSWKSEAEIDMELFHQNHLIVKVPPYHDQHITLPVSVGIYVVTNAGRSHDVQPFTYTPDPAAGALNVNVKKEISSPARPCSFEEAMKAMKTTGCNVDKVTILPNALITPLISSSMIKTEDVTPMEVTSEKRSSPIFQTTKSIGSTQQTLETISNIAGGAPFSSPSSSSHLTPESENQQQLQPKAYNPETLTTIQTQDISQPGTFPAVSAASQLPSSDALLQQATQFQTREAQSRDTIQSDTVVNLSQLTEASQQQQSPLQEQAQTLQQQIPSNIFPSPSSVSQLQSTIQQLQAGSFTGSAAGGRSGSVDLVQQVLEAQQQLSSVLFSTPDGNENVQEQLNADIFQVSQIQNSVSPGMFSSAESAVHTRPDNLLPGRADSVHQQTENTLSNQQQQQQQQQQVMESSAAMVMEMQQSICQAAAQIQSELFPSAASASGSLQQSPVYQQPSHMMSALPTNEDMQMQCELFSSPPAASGNETSTTTTPQVATPGSTMFQTPSSGDGEETGAQAKQIQNSVFQTMVQMQRSGDSQPQVNLFSSTKNIMSVQNNGTQQQGNSLFQQGSEMMSLQSGNFLQQSSHSQAQLFHPQNPIADAQNLSQETQGSIFHSPNPIVHSQTSTASSEQLQPSMFHSQNTIAVLQGSSVPQDQQSPNIFLSQSSINNLQTNTVAQEEQISFFAAQNSISPLQSTSNTEQQAAFQQQPPISHIQTPILSQEQAQPSQQGLFQPQESLHSHITPDACK

Cf. http://cpansearch.perl.org/src/KCLARK/Bio-GenBankParser-0.05/lib/Bio/GenBankParser.pm

## 03-bio-searchio.pl

Run the following commands to format the file for using as a BLAST database:

    $ module load blast
    $ makeblastdb -in uniprot_sprot.fasta -dbtype prot
                    
Select three sequences from the "HDAC.fa" file:

    $ ./parse-fasta.pl HDAC.fa 3 > query.fa
    $ blastp -query query.fa -db uniprot_sprot.fasta -evalue 1e-10 -out query_v_sprot.blastout
            
Cf: BLAST+ at http://www.ncbi.nlm.nih.gov/books/NBK1763/

Write a script to parse your Blast output using "Bio::SearchIO." 
For hits with "significance" less than or equal to 1e-50 retrieve 
every HSP and print in a tab delimited format:

* Query Name
* Hit Name
* HSP Evalue

    $ ./03-bio-searchio.pl
    Usage: 03-bio-searchio.pl blast.out
    
    $ ./03-bio-searchio.pl query_v_sprot.blastout > hits.tab

    $ wc -l hits.tab
    111 hits.tab

    $ head -2 hits.tab
    query   hit evalue
    MHSPGAGCPALQPDTPGSQPQPMDLRVGQRPTVEPPPEPALLTLQHPQRLHRHLFLAGLHQQQRSAEPMRLSMDPPMPELQGGQQEQELRQLLNKDKSKRSAVASSVVKQKLAEVILKKQQAALERTVHPSSPSIPYRTLEPLDTEGAARSVLSSFLPPVPSLPTEPPEHFPLRKTVSEPNLKLRYKPKKSLERRKNPLLRKESAPPSLRRRPAETLGDSSPSSSSTPASGCSSPNDSEHGPNPALGSEADGDRRTHSTLGPRGPVLGNPHAPLFLHHGLEPEAGGTLPSRLQPILLLDPSVSHAPLWTVPGLGPLPFHFAQPLLTTERLSGSGLHRPLNRTRSEPLPPSATASPLLAPLQPRQDRLKPHVQLIKPAISPPQRPAKPSEKPRLRQIPSAEDLETDGGGVGPMANDGLEHRESGRGPPEGRGSISLQQHQQVPPWEQQHLAGRLSQGSPGDSVLIPLAQVGHRPLSRTQSSPAAPVSLLSPEPTCQTQVLNSSETPATGLVYDSVMLKHQCSCGDNSKHPEHAGRIQSIWSRLQERGLRSQCECLRGRKASLEELQSVHSERHVLLYGTNPLSRLKLDNGKLTGLLAQRTFVMLPCGGVGVDTDTIWNELHSSNAARWAAGSVTDLAFKVASRELKNGFAVVRPPGHHADHSTAMGFCFFNSVAIACRQLQQHGKASKILIVDWDVHHGNGTQQTFYQDPSVLYISLHRHDDGNFFPGSGAVDEVGTGSGEGFNVNVAWAGGLDPPMGDPEYLAAFRIVVMPIAREFAPDLVLVSAGFDAAEGHPAPLGGYHVSAKCFGYMTQQLMNLAGGAVVLALEGGHDLTAICDASEACVAALLGNKVDPLSEESWKQKPNLSAIRSLEAVVRVHRKYWGCMQRLASCPDSWLPRVPGADAEVEAVTALASLSVGILAEDRPSERLVEEEEPMNL  MHSPGAGCPALQPDTPGSQPQPMDLRVGQRPTVEPPPEPALLTLQHPQRLHRHLFLAGLHQQQRSAEPMRLSMDPPMPELQGGQQEQELRQLLNKDKSKRSAVASSVVKQKLAEVILKKQQAALERTVHPSSPSIPYRTLEPLDTEGAARSVLSSFLPPVPSLPTEPPEHFPLRKTVSEPNLKLRYKPKKSLERRKNPLLRKESAPPSLRRRPAETLGDSSPSSSSTPASGCSSPNDSEHGPNPALGSEADGDRRTHSTLGPRGPVLGNPHAPLFLHHGLEPEAGGTLPSRLQPILLLDPSVSHAPLWTVPGLGPLPFHFAQPLLTTERLSGSGLHRPLNRTRSEPLPPSATASPLLAPLQPRQDRLKPHVQLIKPAISPPQRPAKPSEKPRLRQIPSAEDLETDGGGVGPMANDGLEHRESGRGPPEGRGSISLQQHQQVPPWEQQHLAGRLSQGSPGDSVLIPLAQVGHRPLSRTQSSPAAPVSLLSPEPTCQTQVLNSSETPATGLVYDSVMLKHQCSCGDNSKHPEHAGRIQSIWSRLQERGLRSQCECLRGRKASLEELQSVHSERHVLLYGTNPLSRLKLDNGKLTGLLAQRTFVMLPCGGVGVDTDTIWNELHSSNAARWAAGSVTDLAFKVASRELKNGFAVVRPPGHHADHSTAMGFCFFNSVAIACRQLQQHGKASKILIVDWDVHHGNGTQQTFYQDPSVLYISLHRHDDGNFFPGSGAVDEVGTGSGEGFNVNVAWAGGLDPPMGDPEYLAAFRIVVMPIAREFAPDLVLVSAGFDAAEGHPAPLGGYHVSAKCFGYMTQQLMNLAGGAVVLALEGGHDLTAICDASEACVAALLGNKVDPLSEESWKQKPNLSAIRSLEAVVRVHRKYWGCMQRLASCPDSWLPRVPGADAEVEAVTALASLSVGILAEDRPSERLVEEEEPMNL  0.0