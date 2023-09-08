# Delphi with MongoDB CRUD Documentation

This documentation provides an overview of a Delphi application that implements CRUD operations using MongoDB as the backend database. The application includes a REST API built with HORSE, a popular Delphi web framework. Below, you'll find information on how to set up, run, and use this application.

## Table of Contents

1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Getting Started](#getting-started)
   - [Running the API Server](#running-the-api-server)
4. [API Endpoints](#api-endpoints)
   - [GET](#get)
   - [POST](#post)
   - [PUT](#put)
   - [DELETE](#delete)

## Introduction

The Delphi with MongoDB CRUD application is designed to perform CRUD operations (Create, Read, Update, Delete) on a MongoDB database using a RESTful API. The application includes a Delphi form for configuring the API server settings.

## Prerequisites

Before you get started with the Delphi with MongoDB CRUD application, make sure you have the following prerequisites in place:

- Delphi IDE installed on your system.
- MongoDB server running and accessible.
- HORSE library for Delphi installed.

## Getting Started

1. Clone this repository to your local machine.

2. Open the Delphi project using your Delphi IDE.

3. Inside the project, locate the "Form" designed for the application's settings.

4. In the form, you will find a field to specify the port on which the API server will run. You can also find a button to start and stop the server.

### Running the API Server

1. Set the desired port for the API server.

2. Click the "Start Server" button to activate the API server. You will see server logs indicating that the server has started successfully.

3. Once the server is running, you can proceed to use the API endpoints for CRUD operations.

## API Endpoints

The API provides the following CRUD operations for managing data in the MongoDB database.

### GET

- **Description:** Retrieve data from the database.
- **Endpoint:** `/api/data`
- **Usage:** Simply make a GET request to this endpoint to retrieve data. No JSON payload is required.

### POST

- **Description:** Insert data into the database.
- **Endpoint:** `/api/data`
- **Request Body:** JSON payload with data to be inserted. The JSON should follow the format below:

```json
{
  "cod_pessoa": "2",
  "nome": "LUCIANO",
  "idade": 25,
  "sexo": "M",
  "trabalho": "ESTUDANTE"
}
```

### PUT

- **Description:** Modify existing data in the database.
- **Endpoint:** `/api/data`
- **Request Body:** JSON payload with data to be modified. The JSON should follow the format below, including the cod_pessoa field to identify the record to be updated:

```json
{
  "cod_pessoa": "2",
  "nome": "Luciano Arantes",
  "idade": 24,
  "sexo": "M",
  "trabalho": "Estudante"
}
```
### DELETE

- **Description:** Delete data from the database.
- **Endpoint:** `/api/data`
- **Request Body:** JSON payload with the cod_pessoa field to specify which record should be deleted. For example:

```json
{
  "cod_pessoa": "2"
}
```
