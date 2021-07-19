Init_general;
strategies = {'1 pump highest demand strategy one rev';...
     '1 pump highest demand strategy'; ...
     '1 pump interval strategy'; ...
     '2 pumps highest demand strategy one rev'; ...
     '2 pumps highest demand strategy'; ...
     '2 pumps interval strategy'};
mdl_name = 'sim_mdl';
to_sim = [1 2 3 4 5 6]; % select which strategies to simulate
nr_strategies = 6;

folder = 'strategy_compare/';
dataset_name = 'set1_';

load('strategy_compare/ref_1e-3')

for strategy_ind=to_sim
    for block_nr=1:nr_strategies
        if strcmp(strategies(block_nr),strategies(strategy_ind))
            set_param(char(strcat(mdl_name,'/',strategies(block_nr))),'commented','off');
        else
            set_param(char(strcat(mdl_name,'/',strategies(block_nr))),'commented','on');
        end
    end
    strategy_select = strategy_ind;
    out = sim(mdl_name);
    out.MSE = mean((out.actual-ref.actual_OD).^2,1);
    out.RMSE = sqrt(out.MSE);
    out.ME = mean(abs(out.actual-ref.actual_OD),1);
    
    save(join([folder,dataset_name,num2str(strategy_ind)]),'out','-v7.3');
    disp(join(['finished simulation and saving of strategy nr. ',num2str(strategy_ind)]));
end



 