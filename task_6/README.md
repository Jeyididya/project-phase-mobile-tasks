
## Submission — Task 6

This README documents the submission for Task 6. The screenshots below illustrate the app UI and key features implemented for this task.

### Features implemented
- Basic Flutter app structure used for Task 6.
- UI screens and interactions shown in screenshots.
- Assets and layout validated on device/emulator.

### Screenshots
<table>
    <tr>
        <td align="center">
            <img src="wiki/task_6/home_page.jpg" alt="Home" width="260"/><br/>
            Home
        </td>
        <td align="center">
            <img src="wiki/task_6/detail_page.jpg" alt="Detail" width="260"/><br/>
            Detail
        </td>
        <td align="center">
            <img src="wiki/task_6/add_product_page.jpg" alt="Add Product" width="260"/><br/>
            Add Product
        </td>
        <td align="center">
            <img src="wiki/task_6/search_page.jpg" alt="Search" width="260"/><br/>
            Search
        </td>
    </tr>
</table>



## Submission — Task 7

Task 7 implements app routing using named routes and demonstrates passing data from the Add page back to the Home page.

### Features implemented
- Configured named routes in MaterialApp.
- Using named routes to pass data from the add page to the home page.

### Video
    
<video controls width="360" height="640" style="max-width:100%; aspect-ratio:9/16;">
    <source src="wiki/task_7/task_7.mp4" type="video/mp4">
    Your browser does not support the video tag. Download/open the video directly:
    <a href="https://github.com/Jeyididya/project-phase-mobile-tasks/raw/main/task_6/wiki/task_7/task_7.mp4">task_7.mp4</a>
    Your browser does not support the video tag. Download/open the video directly:
    <a href="https://github.com/Jeyididya/project-phase-mobile-tasks/raw/main/task_6/wiki/task_7/task_7.mp4">task_7.mp4</a>
</video>

Use this [link](https://github.com/Jeyididya/project-phase-mobile-tasks/blob/main/task_6/wiki/task_7/task_7.mp4) if playback fails.
Use this [link](https://github.com/Jeyididya/project-phase-mobile-tasks/blob/main/task_6/wiki/task_7/task_7.mp4) if playback fails.

If screenshots/videos are not visible, ensure the `wiki/` folder exists at the repository root and contains the referenced files.

## Submission — Task 8

- Prepared tests for:
    - Test Product Listing — [test/product_list_test.dart](test/product_list_test.dart) 
    - Test Product Creation [test/product_creation_test.dart](test/product_creation_test.dart) 
    - Test Product Detail Page Navigation [test/detail_page_navigation_test.dart](test/detail_page_navigation_test.dart) 



## Submission - Task 10

# Clean Architecture — Data Overview Layer

### Project Structure
This project uses Clean Architecture:

lib/
|-- core/ # Shared utilities
|-- features/
| --- products/
| --- domain/ # Entities & usecases
| --- data/ # Models & repositories
| --- presentation/ # UI (screens)
|---main.dart 

###  Data Flow

#### Domain → Pure business rules  
- Product Entity  
- Repository interface  
- Usecases  

#### Data  Implementation  
- ProductModel (JSON)
- Repository implementation

#### Presentation  UI  
- Widgets, screens, state management


# Task 11 - Contracts of Data Sources

## Data Flow

### Domain Layer → Pure Business Rules
- Product Entity: Immutable business object
- Repository Interface: Abstract contract defining data operations
- Use Cases: Single-purpose business logic classes

### Data Layer → Implementation Details
- ProductModel: Extends Product entity, adds JSON serialization
- Data Source Contracts: Abstract interfaces for remote/local operations
- Repository Implementation: Uses contracts, switches based on connectivity
- NetworkInfo: Abstracts network status checking

### Presentation Layer → UI

- Dependency Injection: Services provided via GetIt

## Key Contracts Added
1. ProductRemoteDataSource: Defines remote API operations
2. ProductLocalDataSource: Defines local storage operations
3. NetworkInfo: Abstracts connectivity status
