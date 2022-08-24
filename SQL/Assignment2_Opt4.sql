-- Exercise 1 -
-- Question1 Viết truy vấn lấy các cột ProductID, Name, Color và ListPrice từ bảng Production.Product,
-- không có bộ lọc. Tập hợp kết quả của bạn sẽ giống như sau.
SELECT Production.Product.ProductID, Production.Product.Name, Production.Product.Color, Production.Product.ListPrice FROM Production.Product

-- Question2 Continue to work with the previous query and exclude those rows that are 0 for the column ListPrice. Your result set should look something like the following.  
SELECT Production.Product.ProductID, Production.Product.Name, Production.Product.Color, Production.Product.ListPrice FROM Production.Product
WHERE ListPrice != 0

-- Question 3 Use the same query, but this time you just want to see the rows that are NULL for the Color column. Your result set should look something like the following.  
SELECT Production.Product.ProductID, Production.Product.Name, Production.Product.Color, Production.Product.ListPrice FROM Production.Product
WHERE Production.Product.Color IS NULL

--Question 4 Use the same query, but this time you just want to see the rows that are not NULL for the Color column. Your result set should look something like the following.  
SELECT Production.Product.ProductID, Production.Product.Name, Production.Product.Color, Production.Product.ListPrice FROM Production.Product
WHERE Production.Product.Color IS NOT NULL

-- Question 5 Bạn chỉ muốn xem các hàng không phải là NULL cho cột Màu và cột ListPrice có giá trị lớn hơn 0. Tập hợp kết quả của bạn sẽ giống như sau.
SELECT Production.Product.ProductID, Production.Product.Name, Production.Product.Color, Production.Product.ListPrice FROM Production.Product
WHERE Production.Product.Color IS NOT NULL AND Production.Product.ListPrice >0

-- Question 6 Bây giờ chúng ta muốn có một báo cáo nối các cột Tên và Màu từ bảng Sản xuất. 
-- Tập hợp kết quả của bạn sẽ giống như sau. Đảm bảo rằng bạn loại trừ các hàng KHÔNG ĐỦ cho màu cột. Cũng để ý tên cột.
SELECT Production.Product.Name + ':' + Production.Product.Color AS NameAndColor FROM Production.Product WHERE Production.Product.Color IS NOT NULL

--Question 7 Tùy chỉnh truy vấn trước để câu trả lời giống như sau.
SELECT 'NAME: ' + Production.Product.Name + ' -- ' + 'COLOR: ' +Production.Product.Color AS NameAndColor FROM Production.Product WHERE Production.Product.Color IS NOT NULL

--Question 8 Bây giờ chúng ta muốn xem các cột ProductID và Name từ bảng Production.Product được lọc bởi ProductID từ 400 đến 500. 
-- Viết một truy vấn làm cho tập kết quả của bạn trông giống như sau
SELECT Production.Product.ProductID, Production.Product.Name FROM Production.Product WHERE Product.ProductID BETWEEN 400 AND 500

--Question 9 Chúng tôi muốn xem các cột ProductID, Tên và màu từ bảng Sản phẩm. Sản phẩm bị hạn chế với các màu đen và xanh lam
SELECT Production.Product.ProductID, Production.Product.Name, Production.Product.Color FROM Production.Product WHERE Color = 'Black' OR Color = 'Blue'

--Question 10 Viết một truy vấn lấy ra các cột Tên và Danh sách Giá từ bảng Sản phẩm. Tập hợp kết quả của bạn sẽ giống như sau. Thứ tự kết quả được thiết lập bởi cột Tên.
SELECT Production.Product.Name, Production.Product.ListPrice FROM Production.Product WHERE Name LIKE 'S%' ORDER BY Name

--Question 11 Bây giờ chúng tôi muốn có một báo cáo về các sản phẩm bắt đầu bằng chữ S hoặc A. Viết một truy vấn lấy ra các cột Tên và Danh sách Giá từ bảng Sản phẩm
SELECT Production.Product.Name, Production.Product.ListPrice FROM Production.Product WHERE Name LIKE 'S%' OR Name LIKE 'A%' ORDER BY Name

--Question 12 Điều chỉnh truy vấn của bạn để bạn truy xuất các hàng có Tên bắt đầu bằng các chữ cái SPO,
--nhưng sau đó không được theo sau bởi chữ K. Sau số không hoặc nhiều chữ cái này có thể tồn tại
SELECT Production.Product.Name, Production.Product.ListPrice FROM Production.Product WHERE Name LIKE 'SPO%' AND Name NOT LIKE 'SPOK%' ORDER BY Name

--Question 13 Viết truy vấn lấy các màu duy nhất từ bảng Production.Product. 
-- Chúng tôi không muốn xem tất cả các hàng, chỉ những màu nào tồn tại trong cột Màu. Tập hợp kết quả của bạn sẽ giống như sau.
SELECT DISTINCT Production.Product.Color FROM Production.Product

--Question 14 truy vấn ProductSubcategoryID và Color từ bảng Production.Product. 
-- Định dạng và sắp xếp để kết quả được đặt tương ứng như sau. Chúng tôi không muốn bất kỳ hàng nào là NULL. Trong bất kỳ cột nào trong số hai cột trong kết quả.
SELECT Production.Product.ProductSubcategoryID, Production.Product.Color FROM Production.Product GROUP BY Color, ProductSubcategoryID HAVING Color IS NOT NULL AND Product.ProductSubcategoryID IS NOT NULL ORDER BY ProductSubcategoryID

--Question 15 Sửa lại câu query
SELECT ProductSubCategoryID
      , LEFT([Name],35) AS [Name]
      , Color, ListPrice
FROM Production.Product
WHERE ProductSubCategoryID = 1
    OR Color IN ('Red','Black') 
    AND ListPrice BETWEEN 1000 AND 2000
ORDER BY ProductID

-- Question 16 Sử dụng bảng Production.Product để trả về tên sản phẩm, màu sắc và giá niêm yết cho từng sản phẩm.
--  Đối với cột màu, trong đó có NULL, hãy thay thế nó bằng chuỗi Không xác định.
SELECT ISNULL(Production.Product.Color, 'Unknow') AS Color, Production.Product.Name, Production.Product.ListPrice FROM Production.Product

-- Exercise 2

--Question1 Đếm số lượng sản phẩm trong Product
SELECT COUNT(Production.Product.ProductID) AS NumRow FROM Production.Product

--Question 2 Viết truy vấn truy xuất số lượng sản phẩm trong bảng Sản xuất. Sản phẩm được bao gồm trong danh mục con. 
-- Các hàng có NULL trong cột ProductSubcategoryID được coi là không thuộc bất kỳ danh mục con nào.
SELECT COUNT(Production.Product.ProductID) AS HasSubCategoryID FROM Production.Product WHERE Product.ProductSubcategoryID IS NOT NULL

--Question 3 Có bao nhiêu Sản phẩm nằm trong mỗi Danh mục con?
-- Câu trả lời cho điều này là có thể truy xuất được nếu bạn viết một truy vấn sử dụng hàm tổng hợp COUNT kết hợp với mệnh đề GROUP BY.
-- Cột ProductSubcategoryID là một ứng cử viên để tạo nhóm hàng khi truy vấn bảng Sản phẩm.
SELECT Product.ProductSubcategoryID AS HasSubCategoryID, COUNT(Product.ProductID) FROM Production.Product GROUP BY ROLLUP(ProductSubcategoryID)

--Question 4 Một truy vấn không có mệnh đề WHERE và một truy vấn sử dụng mệnh đề WHERE. 
-- Các hàng có NULL trong cột ProductSubcategoryID được coi là không thuộc bất kỳ danh mục con nào.
SELECT COUNT(Product.ProductID) AS NoSubCat FROM Production.Product WHERE Product.ProductSubcategoryID IS NULL 
SELECT COUNT(Product.ProductID) AS NoSubCat FROM Production.Product 


--Question 5 Cần có báo cáo, bảng tổng hợp sản phẩm trong kho. Lần này, hãy viết một truy vấn chống lại một bảng khác, bảng Production.ProductInventory.
SELECT Production.ProductInventory.ProductID, SUM(Production.ProductInventory.Quantity) FROM Production.ProductInventory GROUP BY (ProductInventory.ProductID)

--Question 6Tiếp tục viết câu truy vấn trong bài tập trước. 
-- Thêm mệnh đề WHERE trích xuất các hàng có cột LocationID được đặt thành 40 và giới hạn kết quả chỉ bao gồm các số lượng tóm tắt nhỏ hơn 100.
SELECT Production.ProductInventory.ProductID, SUM(Production.ProductInventory.Quantity) FROM Production.ProductInventory GROUP BY ProductInventory.ProductID, ProductInventory.LocationID HAVING SUM(ProductInventory.Quantity) <100 AND LocationID = 40

--Question 7 Trong câu hỏi này, chúng tôi cũng muốn xem sản phẩm sẽ được giao từ kệ nào. Thêm mã vào truy vấn trước đó.
SELECT ProductInventory.Shelf, Production.ProductInventory.ProductID, SUM(Production.ProductInventory.Quantity) FROM Production.ProductInventory GROUP BY ProductInventory.ProductID, ProductInventory.LocationID, ProductInventory.Shelf HAVING SUM(ProductInventory.Quantity) <100 AND LocationID = 40

--Question 8 Chúng tôi muốn xem số lượng trung bình cho các sản phẩm trong đó cột LocationID có giá trị là 10. Bảng Production.ProductInventory có câu trả lời.
SELECT AVG(ProductInventory.Quantity) AS TheAVG  FROM Production.ProductInventory WHERE LocationID = 10

--Question 9 Để tiếp tục viết truy vấn trước đó, chúng tôi muốn xem kết quả theo kệ loại trừ các hàng có giá trị N / A trong cột Kệ. 
-- Chúng tôi cũng muốn xem tổng giá trị trung bình chỉ dựa trên giá kệ và cũng cho tất cả các sản phẩm ("tổng số").
SELECT AVG(Production.ProductInventory.Quantity)  ,ProductInventory.Shelf, ProductID FROM Production.ProductInventory GROUP BY ProductInventory.Shelf, ProductID, LocationID HAVING ProductInventory.Shelf != 'N/A' AND LocationID = 10

--Question 10 Chúng tôi muốn biết số lượng thành viên (hàng) và giá niêm yết trung bình trong bảng Sản phẩm. Chúng tôi không quan tâm đến bất kỳ hàng nào có Màu và Lớp là rỗng (TRONG đó Lớp KHÔNG ĐỦ VÀ Màu KHÔNG ĐỦ).
SELECT Product.Class, Product.Color, AVG(Product.ListPrice), COUNT(Product.Class) FROM Production.Product GROUP BY GROUPING SETS(Product.Class, Product.Color, ProductID) HAVING Color IS NOT NULL OR Class IS NOT NULL 

--Question 11 Sửa câu query
SELECT ProductSubcategoryID , COUNT(Name) as Counted, GROUPING(ProductSubcategoryID) AS totalGrand FROM Production.Product GROUP BY ROLLUP (ProductSubcategoryID) ORDER BY ProductSubcategoryID