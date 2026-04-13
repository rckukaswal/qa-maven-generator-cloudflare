#!/bin/bash

generate_excel_utils() {
    local output_dir="$1"
    local package_name="$2"

    mkdir -p "$output_dir"

    cat <<EOF > "$output_dir/ExcelUtils.java"
package ${package_name}.utils;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class ExcelUtils {

    private static Workbook workbook;
    private static Sheet    sheet;

    public static void loadFile(String filePath, String sheetName) throws IOException {
        FileInputStream fis = new FileInputStream(new File(filePath));
        workbook = new XSSFWorkbook(fis);
        sheet    = workbook.getSheet(sheetName);
    }

    public static Object[][] getAllData(String filePath, String sheetName) throws IOException {
        loadFile(filePath, sheetName);

        int rowCount = sheet.getLastRowNum();
        int colCount = sheet.getRow(0).getLastCellNum();

        Object[][] data = new Object[rowCount][colCount];

        for (int i = 1; i <= rowCount; i++) {
            Row row = sheet.getRow(i);
            for (int j = 0; j < colCount; j++) {
                Cell cell = row.getCell(j);
                data[i - 1][j] = getCellValue(cell);
            }
        }

        return data;
    }

    public static String getCellData(int rowNum, int colNum) {
        Row  row  = sheet.getRow(rowNum);
        Cell cell = row.getCell(colNum);
        return getCellValue(cell).toString();
    }

    public static void writeData(String filePath, String sheetName,
                                 int rowNum, int colNum, String value) throws IOException {
        loadFile(filePath, sheetName);

        Row  row  = sheet.getRow(rowNum);
        Cell cell = row.createCell(colNum);
        cell.setCellValue(value);

        FileOutputStream fos = new FileOutputStream(new File(filePath));
        workbook.write(fos);
        fos.close();
    }

    public static void closeWorkbook() throws IOException {
        if (workbook != null) {
            workbook.close();
        }
    }

    private static Object getCellValue(Cell cell) {
        if (cell == null) return "";
        switch (cell.getCellType()) {
            case STRING:  return cell.getStringCellValue();
            case NUMERIC: return String.valueOf((long) cell.getNumericCellValue());
            case BOOLEAN: return String.valueOf(cell.getBooleanCellValue());
            default:      return "";
        }
    }
}
EOF
}