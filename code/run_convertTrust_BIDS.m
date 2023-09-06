% analyze and aggregate trust task behavior across all subjects
% make sure you run from the code directory so that paths are correct


clear;


sublist = [10418, 10369, 10541];



for s = 1:length(sublist)
    convertTrust_BIDS(sublist(s));

end

