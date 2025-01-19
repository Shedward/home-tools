import { a_element_selector } from "./tools.js";

function a_hourly_grid(id) {
    const element = a_element_selector("Hourly Grid", id);

    return {
        fill: (
            items,
            cell,
            at = (o) => o.at,
            days = 14,
            cellWidth = 26,
            cellHeight = 12,
            padding = 2,
            insets = 1,
        ) => {
            element().innerHTML = "";

            const svg = document.createElementNS(
                "http://www.w3.org/2000/svg",
                "svg",
            );
            element().appendChild(svg);

            const rows = 24;
            const columns = days;

            const cellFullWidth = cellWidth + padding;
            const cellFullHeight = cellHeight + padding;

            svg.setAttribute("width", columns * cellFullWidth + 2 * insets);
            svg.setAttribute("height", rows * cellFullHeight + 2 * insets);

            const now = new Date();
            const startOfGrid = new Date(
                now.getFullYear(),
                now.getMonth(),
                now.getDate(),
            );
            const startTime = Math.floor(startOfGrid.getTime() / 1000);

            for (let col = 0; col < columns; col++) {
                for (let row = 0; row < rows; row++) {
                    const cellStart =
                        startTime - col * 24 * 60 * 60 + row * 60 * 60;
                    const cellEnd = cellStart + 60 * 60;

                    const itemsInCell = items.filter(
                        (item) => at(item) >= cellStart && at(item) < cellEnd,
                    );

                    const cellContent = cell(itemsInCell);
                    const x = col * cellFullWidth + insets;
                    const y = row * cellFullHeight + insets;

                    if (cellContent) {
                        cellContent.setAttribute("width", cellWidth);
                        cellContent.setAttribute("height", cellHeight);
                        cellContent.setAttribute("x", x);
                        cellContent.setAttribute("y", y);
                        svg.appendChild(cellContent);
                    }
                }
            }
        },
    };
}

export { a_hourly_grid };
