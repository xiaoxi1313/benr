<table style="width:100%;">
	<thead>
		<tr id="selectCategoryTr" class="chooselist" style="display:none;">
			<th>
				<div class="col-sm-5 no-padder m-r">
					<select a="ctg" >
						<option value="-1">请选择</option>
						<s:iterator value="favoriteList" id="favorite" status="u">
							<option value="<s:property value='id' />">
								<s:property value="name" />
							</option>
						</s:iterator>
					</select>
				</div>
			</th>
			<th>
				<a class="iconbtn" onclick="deleteFavorite(this)" href="javascript:void(0)">
					<i class="fa fa-trash-o"></i> 
				</a>
			</th>
		</tr>
	</thead>
</table>