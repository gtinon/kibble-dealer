
module trapezoid(len1, len2, h, thickness, top_offset_x = 0) {
    linear_extrude(height=thickness, center=true, scale = 1.0, $fn = 16) {
        polygon(points = [
            [-len1/2, -h/2],
            [len1/2, -h/2],
            [len2/2 + top_offset_x, h/2],
            [-len2/2 + top_offset_x, h/2],
        ]);
    }
}

module cut(vec=[1,0,0]){
    cube_size = 300;
    difference(){
        for(i=[0:$children-1]) {children();}
        
        base_offset = [sign(vec[0])*cube_size/2,sign(vec[1])*cube_size/2,sign(vec[2])*cube_size/2];
        
        color("#ff0000")
        translate(base_offset + vec)
        cube(cube_size,true);
    }
}