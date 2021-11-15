package com.example.mapper;

import java.util.List;

public interface CampingAttachDAO {
		public void insert(String camp_image, String camp_id);
		public List<String> list(String camp_id);
}
