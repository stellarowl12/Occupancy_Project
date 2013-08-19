close all;

Lab_binary = [2 5 2.5 28];
Lab_fine = [.484 .7462 .7062 .9245];

figure(1);
%suptitle('Lab setting classification (Power Data)');
subplot(1,2,1);
bar(1,Lab_binary(1),'k');
hold on;
bar(2,Lab_binary(2),'b');
bar(3,Lab_binary(3),'r');
bar(4,Lab_binary(4),'y');
hold off;
%set(gca,'XTickLabel',{'DT', 'NB', 'NN', 'BG'});
xlabel('Binary Inference results');
ylabel('Error');
subplot(1,2,2);
bar(1,Lab_fine(1),'k');
hold on;
bar(2,Lab_fine(2),'b');
bar(3,Lab_fine(3),'r');
bar(4,Lab_fine(4),'y');
hold off;
%set(gca,'XTickLabel',{'DT', 'NB', 'NN', 'BG'});
xlabel('Ranged Inference results');
ylabel('Weighted Error');


% labdata = csvread('Lab_power_data_CSV.csv');
% labdata2 = labdata(end-4239:end,:);
% labdata2 = [labdata2 zeros(4240,1)];
% for i=1:length(labdata2)
%     if (labdata2(i,14) < 9 || labdata2(i,14) >= 22)
%         labdata2(i,17) = 0;
%     else
%         labdata2(i,17) = 1;
%     end
% end
% difference = 0;
% for i=1:length(labdata2)
%     if labdata2(i,17)==0
%         if labdata2(i,16)==0
%             delta = 0;
%         elseif labdata2(i,16)==1
%             delta = 1;
% %         elseif labdata2(i,15)==2
% %             delta = 2.5;
% %         elseif labdata2(i,15)==3
% %             delta = 5.5;
% %         elseif labdata2(i,15)==4
% %             delta = 10;
%         end
%     elseif labdata2(i,17)==1
%         if labdata2(i,16)==0
%             delta = 1;
%         elseif labdata2(i,16)==1
%             delta = 0;
% %         elseif labdata2(i,15)==2
% %             delta = 1.5;
% %         elseif labdata2(i,15)==3
% %             delta = 4.5;
% %         elseif labdata2(i,15)==4
% %             delta = 9;
%         end
%     end
%     difference = difference + delta;
% end
% difference/4240