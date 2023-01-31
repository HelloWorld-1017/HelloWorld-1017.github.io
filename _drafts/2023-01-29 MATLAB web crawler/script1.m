% all_page = 185; %已解决
all_page = 1000; %已答复
all_info = {'','',''};
for i_page = 1:1:all_page
%     Path_Page = ['http://www.ilovematlab.cn/forum.php?mod=forumdisplay&fid=6&typeid=606&filter=typeid&typeid=606&page=',num2str(i_page)];   %已解决
    Path_Page = ['http://www.ilovematlab.cn/forum.php?mod=forumdisplay&fid=6&typeid=605&filter=typeid&typeid=605&page=',num2str(i_page)];   %已答复
    Path_Content = urlread(Path_Page);
    Path_List = regexpi(Path_Content,'</font></a>]</em> <a href="\S*"','match');
    Path_List = Path_List';
    Path_List = strrep(Path_List,'</font></a>]</em> <a href=','http://www.ilovematlab.cn/');
    Path_List = strrep(Path_List,'"','');
    Path_Title = regexpi(Path_Content,'class="s xst">.*?</a>','match');
    Path_Title = Path_Title';
    Path_Title = strrep(Path_Title,'class="s xst">','');
    Path_Title = strrep(Path_Title,'</a>','');
    Path_Read = regexpi(Path_Content,'</a><em>\d*</em></td>','match');
    Path_Read = Path_Read';
    Path_Read = strrep(Path_Read,'</a><em>','');
    Path_Read = strrep(Path_Read,'</em></td>','');
    Path_Infor = [Path_Title,Path_List,Path_Read];
    all_info = [all_info;Path_Infor];
    disp(i)
end