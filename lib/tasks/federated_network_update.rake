namespace :federated_network do
 desc 'Task to import federated networks'
   task :update do
     sh 'rails', 'runner', 'include FederatedNetworkUpdater; process_data'
     puts 'Federated Networks are up to date'
   end
end
