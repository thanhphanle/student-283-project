package com.onlinestore.service;

import java.util.List;

import com.onlinestore.model.Status;

public interface StatusService {
	void createStatus(Status status);

	List<Status> getStatuses();

	Status getStatus(Long id);

	void updateStatus(Status status);

	void deleteStatus(Long id);
}
