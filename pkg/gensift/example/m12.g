# $Id: m12.g,v 1.1.1.1 2004/12/22 13:22:48 gap Exp $
# Example for sifting in M12:
LoadPackage("atlasrep");
gens := AtlasGenerators("M12",1);
g := Group(gens.generators);
sr := PrepareSiftRecords(PreSift.M12,g);
ResetGeneralizedSiftProfile(Length(sr));
Print("Results: ",TestGeneralizedSift(sr,g,1/100,50),"\n");
DisplayGeneralizedSiftProfile();