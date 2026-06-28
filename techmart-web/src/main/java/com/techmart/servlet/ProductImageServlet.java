package com.techmart.servlet;

import com.techmart.ejb.config.UploadConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

@WebServlet("/product-image")
public class ProductImageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String path = request.getParameter("path");

        if (path == null || path.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        File baseDir = new File(UploadConfig.UPLOAD_DIRECTORY);
        File image = new File(baseDir, path);

        String canonicalBase = baseDir.getCanonicalPath();
        String canonicalImage = image.getCanonicalPath();

        if (!canonicalImage.startsWith(canonicalBase)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        if (!image.exists() || !image.isFile()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String mimeType = getServletContext().getMimeType(image.getName());
        if (mimeType == null) {
            mimeType = "application/octet-stream";
        }
        response.setContentType(mimeType);

        response.setHeader("Cache-Control", "public, max-age=604800, immutable");
        response.setContentLengthLong(image.length());

        Files.copy(image.toPath(), response.getOutputStream());
    }
}